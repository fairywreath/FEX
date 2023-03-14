#pragma once
#include <fextl/allocator.h>

#include <unordered_map>

namespace fextl {
  template<class Key, class T, class Hash = std::hash<Key>, class KeyEqual = std::equal_to<Key>, class Allocator = fextl::FEXAlloc<std::pair<const Key, T>>>
  using unordered_map = std::unordered_map<Key, T, Hash, KeyEqual, Allocator>;
}