cmake_minimum_required(VERSION 2.8)
project(anagram)

subdirs(src)

file(COPY words DESTINATION .)
