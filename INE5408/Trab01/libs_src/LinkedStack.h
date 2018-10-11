//! Copyright 2018 Thiago Sant' Helena

#pragma once

#include <memory>
#include <stdexcept>

namespace structures {

template<typename T>
//! Main class
class LinkedStack {
 public:
    //! Default constructor
    LinkedStack() = default;

    //! Destructor
    ~LinkedStack() = default;

    //! Clear stack
    void clear() {
        this->size_ = 0;
        this->top_ = nullptr;
    }

    //! Push element on top of stack
    void push(const T& data) {
        if (this->empty()) {
            this->top_ = std::make_shared<Node>(data);

        } else {
            this->top_ = std::make_shared<Node>(data, this->top_);
        }

        this->size_ += 1;
    }

    //! Pop element on the top of stack
    T pop() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }
        auto tmp = this->top_;
        this->top_ = this->top_->next();
        this->size_--;
        return tmp->data();
    }

    //! Return reference to the top element
    T& top() const {
        if (this->empty()) {
            throw std::out_of_range("Empty stack");
        }

        return this->top_->data();
    }

    //! Check if stack is empty
    bool empty() const {
        return this->size() == 0;
    }

    //! Return size of the list
    int size() const {
        return this->size_;
    }

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data):
            data_{data}
        {}

        Node(const T& data, std::shared_ptr<Node> next):
            data_{data}
        {
            next_ = next;
        }

        T& data() {
            return data_;
        }

        const T& data() const {
            return data_;
        }

        std::shared_ptr<Node> next() {
            return next_;
        }

        const std::shared_ptr<Node> next() const {
            return next_;
        }

        void next(std::shared_ptr<Node> node) {
            next_ = node;
        }

     private:
        T data_;
        std::shared_ptr<Node> next_{nullptr};
    };

    std::shared_ptr<Node> top_{nullptr};
    int size_ = 0;
};

}  // namespace structures
