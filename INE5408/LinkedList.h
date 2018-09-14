//! Copyright 2018 Thiago Sant' Helena
#pragma once

#include <stdexcept>  // C++ Exceptions
#include <memory>     // smart pointers

namespace structures {

//! ...
template<typename T>
class LinkedList {
 public:
    //! Constructor
    LinkedList() = default;

    //! Destructor
    ~LinkedList() = default;

    //! Clear the list
    void clear() {
        this->size_ = 0;
        this->head = nullptr;
    }

    //! Push data on last position
    void push_back(const T& data) {
        if (this->empty()) {
            this->head = std::make_shared<Node>(data);

        } else {
            auto new_node = std::make_shared<Node>(data);
            this->end()->next(new_node);
        }

        this->size_ += 1;
    }


    //! Push data on first position
    void push_front(const T& data) {
        if (this->empty()) {
            this->head = std::make_shared<Node>(data);

        } else {
            this->head = std::make_shared<Node>(data, this->head);
        }

        this->size_ += 1;
    }

    //! Insert data on target index
    void insert(const T& data, int index) {
        if (index < 0 || index > this->size()) {
            throw std::out_of_range("Index out of bounds.");
        }

        if (index == 0) {
            this->push_front(data);
            return;

        } else if (index == this->size()) {
            this->push_back(data);
            return;
        }

        std::shared_ptr<Node> prev = nullptr;
        auto it = this->head;
        for (int i = 0; i < index; i++) {
            prev = it;
            it = it->next();
        }
        auto new_data = std::make_shared<Node>(data, it);
        prev->next(new_data);

        this->size_++;
    }

    //! Insert data in order
    void insert_sorted(const T& data) {
        // If list is empty, just push
        if (this->empty()) {
            this->push_back(data);
            return;
        }

        auto it = this->head;
        int index = 0;

        while (it->data() < data) {
            it = it->next();
            index++;

            // If reach the last object, push on last pos
            if (it == nullptr) {
                this->push_back(data);
                return;
            }
        }

        this->insert(data, index);
    }

    //! Return data at index
    T& at(int index) {
        if (index < 0 || index >= this->size()) {
            throw std::out_of_range("Index out of bounds.");
        }

        auto it = this->head;
        for (int i = 0; i < index; i++) {
            it = it->next();
        }

        return it->data();
    }

    //! Remove and return target index
    T pop(int index) {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }
        if (index >= this->size() || index < 0) {
            throw std::out_of_range("Index out of bounds.");
        }
        if (index == 0) {
            return this->pop_front();
        }
        if (index == this->size_ - 1) {
            return this->pop_back();
        }

        auto before = this->head;
        for (int i = 0; i < index-1; i++) {
            before = before->next();
        }

        auto indexed = this->head;
        for (int i = 0; i < index; i++) {
            indexed = indexed->next();
        }

        auto tmp = indexed->data();
        before->next(indexed->next());

        this->size_--;

        return tmp;
    }

    //! Remove and return last item
    T pop_back() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }

        auto tmp = this->end()->data();

        auto it = this->head;
        for (int i = 0; i < this->size()-1; i++) {
            it = it->next();
        }

        it->next(nullptr);
        this->size_--;
        return tmp;
    }

    //! Remove and return first item
    T pop_front() {
        if (this->empty()) {
            throw std::out_of_range("Empty list");
        }
        auto tmp = this->head;
        this->head = this->head->next();
        this->size_--;
        return tmp->data();
    }

    //! Remove target data
    void remove(const T& data)  {
        auto index = this->find(data);
        if (index != this->size()) {
            this->pop(index);
        }
    }

    //! Check for empty list
    bool empty() const {
        return this->size() == 0;
    }

    //! Check if lsit contains data
    bool contains(const T& data) const {
        return this->find(data) != this->size();
    }

    //! Find index of data in list, return size if don't find
    int find(const T& data) const {
        auto it = this->head;
        int i = 0;
        while (it != nullptr) {
            if (it->data() == data) {
                return i;
            }

            i++;
            it = it->next();
        }

        return i;
    }

    //! List size
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

    std::shared_ptr<Node> end() {
        auto it = head;
        for (int i = 1; i < size(); ++i) {
            it = it->next();
        }
        return it;
    }

    std::shared_ptr<Node> head{nullptr};
    int size_{0};
};

}  // namespace structures
