#include <v8.h>
#include <node.h>

#include <unistd.h>

using namespace node;
using namespace v8;

#define REQ_FUN_ARG(I, VAR)                                             \
  if (args.Length() <= (I) || !args[I]->IsFunction())                   \
    return ThrowException(Exception::TypeError(                         \
                  String::New("Argument " #I " must be a function")));  \
  Local<Function> VAR = Local<Function>::Cast(args[I]);

int factorial(int n) {
  int temp;
  if (n <= 1) {
    return 1;
  }
  temp = n + factorial(n - 1);
  return temp;
}

struct factorial_baton_t {
  int number;
  int sleep_for;
  Persistent<Function> callback;
};

int EIO_Factorial(eio_req *req)
{
  factorial_baton_t *baton = static_cast<factorial_baton_t *>(req->data);
  //sleep(baton->sleep_for);
  baton->number = factorial(baton->number);
  return 0;
}

int EIO_AfterFactorial(eio_req *req)
{
  HandleScope scope;
  factorial_baton_t *baton = static_cast<factorial_baton_t *>(req->data);
  ev_unref(EV_DEFAULT_UC);

  Local<Value> argv[1];

  argv[0] = Number::New(baton->number);

  TryCatch try_catch;

  baton->callback->Call(Context::GetCurrent()->Global(), 1, argv);

  if (try_catch.HasCaught()) {
    FatalException(try_catch);
  }

  baton->callback.Dispose();

  delete baton;
  return 0;
}

Handle<Value> Factorial(const Arguments& args)
{
  HandleScope scope;

  if (!args[0]->IsNumber()) {
    ThrowException(Exception::TypeError(String::New("Wrong arguments")));
    return scope.Close(Undefined());
  }

  REQ_FUN_ARG(1, cb);

  factorial_baton_t *baton = new factorial_baton_t();
  baton->number = args[0]->NumberValue();
  baton->sleep_for = 1;
  baton->callback = Persistent<Function>::New(cb);

  eio_custom(EIO_Factorial, EIO_PRI_DEFAULT, EIO_AfterFactorial, baton);
  ev_ref(EV_DEFAULT_UC);

  return Undefined();
}

void init(Handle<Object> target)
{
  NODE_SET_METHOD(target, "factorial", Factorial);
}

extern "C" {
  NODE_MODULE(factorial_eio, init);
}
