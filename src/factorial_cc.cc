#include <v8.h>
#include <node.h>

using namespace node;
using namespace v8;

int factorial(int n) {
  int temp;
  if (n <= 1) {
    return 1;
  }
  temp = n + factorial(n - 1);
  return temp;
}

Handle<Value> Factorial(const Arguments& args) {
  HandleScope scope;
  if (!args[0]->IsNumber()) {
    ThrowException(Exception::TypeError(String::New("Wrong arguments")));
    return scope.Close(Undefined());
  }
  int n = args[0]->NumberValue();
  return scope.Close(Number::New(factorial(n)));
}

void init(Handle<Object> target)
{
  NODE_SET_METHOD(target, "factorial", Factorial);
}

extern "C" {
  NODE_MODULE(factorial_cc, init);
}
