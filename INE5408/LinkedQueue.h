//! Copyright 2018 Thiago Sant' Helena

#pragma once

#include <memory>
#include <stdexcept>


namespace structures {
template<typename T>
//! Main class
class LinkedQueue {
 public:
    //! Default constructor
    LinkedQueue() = default;

    //! Default constructor
    ~LinkedQueue() = default;

    //! Clear stack
    void clear() {
        this->size_ = 0;
        this->head = nullptr;
        this->tail = nullptr;
    }


    //! Put a element on the queue
    void enqueue(const T& data) {
        auto new_node = std::make_shared<Node>(data);

        if (this->empty()) {
            this->tail = new_node;
            this->head = new_node;
        } else {
            this->tail->next(new_node);
            this->tail = new_node;
        }

        this->size_++;
    }

    //! Pop first element of the queue
    T dequeue() {
        if (this->empty()) {
            throw std::out_of_range("Empty queue!");
        }

        auto ret = this->head;

        this->head = this->head->next();

        if (this->size_ == 1) {
            this->tail = nullptr;
        }

        this->size_--;

        return ret->data();
    }

    //! Return reference to the first element of queue
    T& front() const {
        if (this->empty()) {
            throw std::out_of_range("Empty queue!");
        }

        return this->head->data();
    }

    //! Return reference to the last element of queue
    T& back() const {
        if (this->empty()) {
            throw std::out_of_range("Empty queue!");
        }

        return this->tail->data();
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

    std::shared_ptr<Node> head{nullptr};
    std::shared_ptr<Node> tail{nullptr};
    int size_ = 0;
};

}  // namespace structures

