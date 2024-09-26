#include <stdio.h>

struct S {
    void (*f)(void);
    void (*g)(void);
};

void A() {
    puts("A");
}

void B() {
    puts("B");
}

void C(struct S *s) {
    s->f();
    s->g();
}

int main() {
    struct S s = {A, B};
    C(&s);
}
