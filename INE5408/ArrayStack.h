/// Copyright 2018 Thiago Sant' Helena

#ifndef INE5408_ARRAYSTACK_H_
#define INE5408_ARRAYSTACK_H_

#include <cstdint>  // std::size_t
#include <stdexcept>  // C++ exceptions
#include <memory>

namespace structures {

template <typename T>
/// Main class of implemented stack
class ArrayStack {
 public:
    ArrayStack();

    /// Construtor com tamanho
    explicit ArrayStack(std::size_t max);

    ~ArrayStack() = default;

    /// empilha
    void push(const T& data);

    /// desempilha
    T pop();

    /// ref to the top value
    T& top();

    /// limpa
    void clear();

    /// tamanho
    std::size_t size();

    /// max size of stack
    std::size_t max_size();

    /// vazia
    bool empty();

    /// cheia
    bool full();

 private:
    static const auto DEFAULT_SIZE = 10u;

    std::unique_ptr<T[]> contents;
    int top_;
    std::size_t max_size_;
};

}  // namespace structures

template <typename T>
structures::ArrayStack<T>::ArrayStack() {
    this->ArrayStack(this->DEFAULT_SIZE);
}

template <typename T>
structures::ArrayStack<T>::ArrayStack(std::size_t max) {
    this->max_size_ = max;
    this->top_ = -1;

    // this->contents = new T[this->max_size_];
    this->contents = std::unique_ptr<T[]>(new T[this->max_size_]);
}

template <typename T>
structures::ArrayStack<T>::~ArrayStack() {
    // delete this->contents;  no need because of std::unique_ptr
}

template <typename T>
void structures::ArrayStack<T>::push(const T& data) {
    if (!this->top_ < static_cast<int>(this->max_size_-1)) {
        throw std::out_of_range("Stack overflow");
    }

    this->top_ += 1;
    this->contents[this->top_] = data;
}

template <typename T>
T structures::ArrayStack<T>::pop() {
    if (this->empty()) {
        throw std::out_of_range("Stack is empty");
    }

    int tmp = this->top_;
    this->top_ -= 1;
    return this->contents[tmp];
}

template <typename T>
T& structures::ArrayStack<T>::top() {
    return this->contents[this->top_];
}

template <typename T>
void structures::ArrayStack<T>::clear() {
    while (this->top_ > -1) this->pop();
}

template <typename T>
std::size_t structures::ArrayStack<T>::size() {
    return this->top_ + 1;
}

template <typename T>
std::size_t structures::ArrayStack<T>::max_size() {
    return this->max_size_;
}

template <typename T>
bool structures::ArrayStack<T>::full() {
    return this->top_ == static_cast<int>(this->max_size_ - 1);
}

template <typename T>
bool structures::ArrayStack<T>::empty() {
    return this->top_ == -1;
}

#endif  // INE5408_ARRAYSTACK_H_
