/// Copyright 2018 Thiago Sant' Helena

#ifndef STRUCTURES_ARRAY_QUEUE_H
#define STRUCTURES_ARRAY_QUEUE_H

#include <cstdint>  // std::size_t
#include <stdexcept>  // C++ Exceptions
#include <memory>  // uni_ptr

namespace structures {

template <typename T>
/// Main class
class ArrayQueue {
 public:
    /// Default constructor
    ArrayQueue();

    /// Constructor with size
    explicit ArrayQueue(std::size_t max);

    /// Destructor
    ~ArrayQueue();

    ///  Add element
    void enqueue(const T& data);

    /// Remove element
    T dequeue();

    /// Take element from end of queue
    T& back();

    /// Clear queue
    void clear();

    /// Getter for actual size
    std::size_t size();

    /// Getter for maximum size
    std::size_t max_size();

    /// Is empty function
    bool empty();

    /// Is full function
    bool full();

 private:
    std::unique_ptr<T[]> contents;
    std::size_t size_;
    std::size_t max_size_;

    int init;
    int end;

    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures

template <typename T>
structures::ArrayQueue<T>::ArrayQueue() {
    this->ArrayQueue(this->DEFAULT_SIZE);
}

template <typename T>
structures::ArrayQueue<T>::ArrayQueue(std::size_t max) {
    this->max_size_ = max;
    this->size_ = 0;
    this->contents = std::unique_ptr<T[]>(new T[this->max_size_]);
}

template <typename T>
structures::ArrayQueue<T>::~ArrayQueue() {
}

template <typename T>
void structures::ArrayQueue<T>::enqueue(const T& data) {
    if (this->full()) {
        throw std::out_of_range("Queue overflow");

    } else {
        this->contents[this->size_] = data;
        this->size_++;
    }
}

template <typename T>
T structures::ArrayQueue<T>::dequeue() {
    if (this->empty()) {
        throw std::out_of_range("Empty queue");

    } else {
        T tmp = this->contents[0];

        this->size_--;

        for (int i = 0; i < static_cast<int>(this->size_); i++) {
            this->contents[i] = this->contents[i+1];
        }

        return tmp;
    }
}

template <typename T>
T& structures::ArrayQueue<T>::back() {
    if (this->empty()) {
        throw std::out_of_range("Empty queue");

    } else {
        return this->contents[this->size_-1];
    }
}

template <typename T>
void structures::ArrayQueue<T>::clear() {
    this->size_ = 0;
}

template <typename T>
std::size_t structures::ArrayQueue<T>::size() {
    return this->size_;
}

template <typename T>
std::size_t structures::ArrayQueue<T>::max_size() {
    return this->max_size_;
}

template <typename T>
bool structures::ArrayQueue<T>::full() {
    return this->max_size_ == this->size_;
}

template <typename T>
bool structures::ArrayQueue<T>::empty() {
    return this->size_ == 0;
}

#endif
