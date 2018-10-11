//! Copyright 2018 Thiago Sant' Helena

#pragma once
#include <memory>
#include "ArrayList.h"

namespace structures {

//! Main class
template <typename T>
class BinaryTree {
 public:
    //! Default constructor
    BinaryTree() {
        this->root = nullptr;
        this->size_ = 0;
    }

    //! Destructor
    ~BinaryTree() = default;

    //! Insert new data
    void insert(const T& data) {
        if (this->root == nullptr) {
            this->root = std::make_shared<Node>(data);

        } else if (data > root->data) {
            if (this->root->right != nullptr) {
                this->root->right->insert(data);
            } else {
                this->root->right = std::make_shared<Node>(data);
            }
        } else {
            if (this->root->left != nullptr) {
                this->root->left->insert(data);
            } else {
                this->root->left = std::make_shared<Node>(data);
            }
        }

        this->size_++;
    }

    //! Remove target data
    bool remove(const T& data) {
        if (this->root == nullptr) {
            return false;
        }

        Node* aux = new Node();
        aux->left = this->root;
        aux->right = this->root;
        auto result = this->root->remove(data, aux);
        this->root = aux->left;
        delete aux;
        this->size_--;

        return result;
    }

    //! Check if tree contains target data
    bool contains(const T& data) const {
        if (this->size_ == 0) {
            return false;
        }
        return this->root->contains(data);
    }

    //! Check if list is empty
    bool empty() const {
        return this->size_ == 0;
    }

    //! Return number of elements on the tree
    int size() const {
        return this->size_;
    }

    //! Return itens on a order
    ArrayList<T> pre_order() const {
        auto list = ArrayList<T>(this->size_);
        this->root->pre_order(&list);

        return list;
    }

    //! Return itens on value order
    ArrayList<T> in_order() const {
        auto list = ArrayList<T>(this->size_);
        this->root->in_order(&list);

        return list;
    }

    //! Return itens on insertion order
    ArrayList<T> post_order() const {
        auto list = ArrayList<T>(this->size_);
        this->root->post_order(&list);

        return list;
    }

 private:
    struct Node {
        Node() = default;

        explicit Node(const T& data_) {
            this->data = data_;
        }

        T data;
        std::shared_ptr<Node> left;
        std::shared_ptr<Node> right;

        void insert(const T& data_) {
            if (data_ > this->data) {
                if (this->right == nullptr) {
                    this->right = std::make_shared<Node>(data_);
                } else {
                    this->right->insert(data_);
                }
            } else {
                if (this->left == nullptr) {
                    this->left = std::make_shared<Node>(data_);
                } else {
                    this->left->insert(data_);
                }
            }
        }

        bool is_leaf() {
            return (this->right == nullptr && this->left == nullptr);
        }

        bool remove(const T& data_, Node* parent) {
            if (data_ == this->data) {
                // Leaf
                if (this->is_leaf()) {
                    // Check if this is left or right of parent
                    if ((parent->left != nullptr) &&
                        (this->data == parent->left->data)) {
                        parent->left = nullptr;
                    } else {
                        parent->right = nullptr;
                    }

                    return true;

                // Single sub tree
                } else if ((this->left != nullptr) !=
                           (this->right != nullptr)) {
                    if (this->left != nullptr) {
                        // Check if this is left or right of parent
                        if ((parent->left != nullptr) &&
                            (this->data == parent->left->data)) {
                            parent->left = this->left;
                        } else {
                            parent->right = this->left;
                        }

                        return true;
                    } else {
                        // Check if this is left or right of parent
                        if ((parent->left != nullptr) &&
                            (this->data == parent->left->data)) {
                            parent->left = this->right;
                        } else {
                            parent->right = this->right;
                        }

                        return true;
                    }

                // Two sub trees
                } else {
                    this->data = this->right->minValue();
                    return this->right->remove(this->data, this);
                }
            } else {
                if (this->data > data_) {
                    return this->left->remove(data_, this);
                } else {
                    return this->right->remove(data_, this);
                }
            }
        }

        T minValue() {
            if (this->left != nullptr) {
                return this->left->minValue();
            } else {
                return this->data;
            }
        }


        bool contains(const T& data_) const {
            if (this->data == data_) {
                return true;

            } else if (data_ < this->data) {
                if (this->left == nullptr) {
                    return false;
                } else {
                    return this->left->contains(data_);
                }
            } else {
                if (this->right == nullptr) {
                    return false;
                } else {
                    return this->right->contains(data_);
                }
            }
        }

        void pre_order(ArrayList<T>* v) const {
            v->push_back(this->data);
            if (this->left != nullptr)
                this->left->pre_order(v);
            if (this->right != nullptr)
                this->right->pre_order(v);
        }

        void in_order(ArrayList<T>* v) const {
            if (this->left != nullptr)
                this->left->in_order(v);
            v->push_back(this->data);
            if (this->right != nullptr)
                this->right->in_order(v);
        }

        void post_order(ArrayList<T>* v) const {
            if (this->left != nullptr)
                this->left->post_order(v);
            if (this->right != nullptr)
                this->right->post_order(v);
            v->push_back(this->data);
        }
    };

    int size_;
    std::shared_ptr<Node> root;
};

}  // namespace structures
