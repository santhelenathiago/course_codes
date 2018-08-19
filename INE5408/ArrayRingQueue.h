/// Copyright 2018 Thiago Sant' Helena

#ifndef INE5408_ARRAYRINGQUEUE_H_
#define INE5408_ARRAYRINGQUEUE_H_

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
    explicit ArrayQueue(int max);

    /// Destructor
    ~ArrayQueue() = default;

    ///  Add element
    void enqueue(const T& data);

    /// Remove element
    T dequeue();

    /// Take element from end_ of queue
    T& back();

    /// Clear queue
    void clear();

    /// Getter for actual size
    int size();

    /// Getter for maximum size
    int max_size();

    /// Is empty function
    bool empty();

    /// Is full function
    bool full();

 private:
    std::unique_ptr<T[]> contents;
    int size_;
    int max_size_;

    int init_;
    int end_;

    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures

template <typename T>
structures::ArrayQueue<T>::ArrayQueue() {
    this->ArrayQueue(this->DEFAULT_SIZE);
}

template <typename T>
structures::ArrayQueue<T>::ArrayQueue(int max) {
    this->max_size_ = max;
    this->size_ = 0;
    this->init_ = -1;
    this->end_ = -1;
    this->contents = std::unique_ptr<T[]>(new T[this->max_size_]);
}

template <typename T>
void structures::ArrayQueue<T>::enqueue(const T& data) {
    if (this->full()) {
        throw std::out_of_range("Queue overflow");
    } else if (this->init_ == -1 && this->end_ == -1) {
        this->init_ = 0;
        this->end_ = 0;
        this->contents[0] = data;
        this->size_ += 1;
    } else {
        this->end_ = (this->end_ + 1) % this->max_size_;
        this->contents[this->end_] = data;
        this->size_++;
    }
}

template <typename T>
T structures::ArrayQueue<T>::dequeue() {
    if (this->empty()) {
        throw std::out_of_range("Empty queue");
    }

    T tmp = this->contents[this->init_];
    this->size_ -= 1;
    this->init_ = (this->init_ + 1) % this->max_size_;

    if (this->size_ == 0) {
        this->init_ = -1;
        this->end_ = -1;
    }
    return tmp;
}

template <typename T>
T& structures::ArrayQueue<T>::back() {
    if (this->empty()) {
        throw std::out_of_range("Empty queue");
    }

    return this->contents[this->end_];
}

template <typename T>
void structures::ArrayQueue<T>::clear() {
    this->size_ = 0;
    this->init_ = -1;
    this->end_ = -1;
}

template <typename T>
int structures::ArrayQueue<T>::size() {
    return this->size_;
}

template <typename T>
int structures::ArrayQueue<T>::max_size() {
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

#endif  // INE5408_ARRAYRINGQUEUE_H_
