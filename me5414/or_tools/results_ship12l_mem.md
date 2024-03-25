# Summarized

## Primal
==30400== HEAP SUMMARY:
==30400==     in use at exit: 427,384 bytes in 572 blocks
==30400==   total heap usage: 61,181 allocs, 60,609 frees, 9,477,861 bytes allocated

## Barrier

==30675== HEAP SUMMARY:
==30675==     in use at exit: 427,337 bytes in 571 blocks
==30675==   total heap usage: 61,274 allocs, 60,703 frees, 156,130,290 bytes allocated


# Primal simplex

==30400== 
==30400== HEAP SUMMARY:
==30400==     in use at exit: 427,384 bytes in 572 blocks
==30400==   total heap usage: 61,181 allocs, 60,609 frees, 9,477,861 bytes allocated
==30400== 
==30400== 24 bytes in 1 blocks are definitely lost in loss record 22 of 136
==30400==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x4E98826: File::Open(char const*, char const*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x4E98B4B: file::Open(std::basic_string_view<char, std::char_traits<char> > const&, std::basic_string_view<char, std::char_traits<char> > const&, File**, int) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5302395: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x530225B: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x52F3310: operations_research::glop::MpsFileToMPModelProto(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x12C630: operations_research::loadMPSFile(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400==    by 0x12CFB6: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400== 
==30400== 24 bytes in 1 blocks are definitely lost in loss record 23 of 136
==30400==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x4E98826: File::Open(char const*, char const*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x4E98B4B: file::Open(std::basic_string_view<char, std::char_traits<char> > const&, std::basic_string_view<char, std::char_traits<char> > const&, File**, int) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5302395: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5302291: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x52F3310: operations_research::glop::MpsFileToMPModelProto(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x12C630: operations_research::loadMPSFile(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400==    by 0x12CFB6: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400== 
==30400== 32 bytes in 1 blocks are possibly lost in loss record 32 of 136
==30400==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x5749769: google::protobuf::internal::ArenaStringPtr::Mutable[abi:cxx11](google::protobuf::Arena*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x579C4C3: google::protobuf::FileOptions::_InternalParse(char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x583469D: bool google::protobuf::internal::MergeFromImpl<false>(std::basic_string_view<char, std::char_traits<char> >, google::protobuf::MessageLite*, google::protobuf::MessageLite::ParseFlags) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5786325: void google::protobuf::DescriptorBuilder::AllocateOptionsImpl<google::protobuf::FileDescriptor>(std::basic_string_view<char, std::char_traits<char> >, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::FileDescriptor::OptionsType const&, google::protobuf::FileDescriptor*, std::vector<int, std::allocator<int> > const&, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5768B02: google::protobuf::DescriptorBuilder::AllocateOptions(google::protobuf::FileOptions const&, google::protobuf::FileDescriptor*, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5770836: google::protobuf::DescriptorBuilder::BuildFileImpl(google::protobuf::FileDescriptorProto const&, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5771F35: google::protobuf::DescriptorBuilder::BuildFile(google::protobuf::FileDescriptorProto const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5772CA8: google::protobuf::DescriptorPool::BuildFileFromDatabase(google::protobuf::FileDescriptorProto const&) const (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5773006: google::protobuf::DescriptorPool::TryFindFileInFallbackDatabase(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x577338D: google::protobuf::DescriptorPool::FindFileByName(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x57D41C5: google::protobuf::(anonymous namespace)::AssignDescriptorsImpl(google::protobuf::internal::DescriptorTable const*, bool) (in /usr/local/lib/libortools.so.9.7.2996)
==30400== 
==30400== 32 bytes in 1 blocks are possibly lost in loss record 33 of 136
==30400==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x69A738D: std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_mutate(unsigned long, unsigned long, char const*, unsigned long) (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28)
==30400==    by 0x69A7EBF: std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_replace_aux(unsigned long, unsigned long, unsigned long, char) (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28)
==30400==    by 0x583717C: google::protobuf::internal::InlineGreedyStringParser(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x579C4D1: google::protobuf::FileOptions::_InternalParse(char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x583469D: bool google::protobuf::internal::MergeFromImpl<false>(std::basic_string_view<char, std::char_traits<char> >, google::protobuf::MessageLite*, google::protobuf::MessageLite::ParseFlags) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5786325: void google::protobuf::DescriptorBuilder::AllocateOptionsImpl<google::protobuf::FileDescriptor>(std::basic_string_view<char, std::char_traits<char> >, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::FileDescriptor::OptionsType const&, google::protobuf::FileDescriptor*, std::vector<int, std::allocator<int> > const&, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5768B02: google::protobuf::DescriptorBuilder::AllocateOptions(google::protobuf::FileOptions const&, google::protobuf::FileDescriptor*, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5770836: google::protobuf::DescriptorBuilder::BuildFileImpl(google::protobuf::FileDescriptorProto const&, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5771F35: google::protobuf::DescriptorBuilder::BuildFile(google::protobuf::FileDescriptorProto const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5772CA8: google::protobuf::DescriptorPool::BuildFileFromDatabase(google::protobuf::FileDescriptorProto const&) const (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x5773006: google::protobuf::DescriptorPool::TryFindFileInFallbackDatabase(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30400== 
==30400== 47 bytes in 1 blocks are definitely lost in loss record 46 of 136
==30400==    at 0x483B7F3: malloc (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x4018CFD: _dl_exception_create (dl-exception.c:78)
==30400==    by 0x6BC3A97: _dl_signal_error (dl-error-skeleton.c:117)
==30400==    by 0x400AD89: _dl_map_object (dl-load.c:2231)
==30400==    by 0x4015D46: dl_open_worker (dl-open.c:513)
==30400==    by 0x6BC3B47: _dl_catch_exception (dl-error-skeleton.c:208)
==30400==    by 0x4015609: _dl_open (dl-open.c:837)
==30400==    by 0x6C5634B: dlopen_doit (dlopen.c:66)
==30400==    by 0x6BC3B47: _dl_catch_exception (dl-error-skeleton.c:208)
==30400==    by 0x6BC3C12: _dl_catch_error (dl-error-skeleton.c:227)
==30400==    by 0x6C56B58: _dlerror_run (dlerror.c:170)
==30400==    by 0x6C563D9: dlopen@@GLIBC_2.2.5 (dlopen.c:87)
==30400== 
==30400== 351,469 (37,728 direct, 313,741 indirect) bytes in 1 blocks are definitely lost in loss record 136 of 136
==30400==    at 0x483DD99: calloc (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30400==    by 0x8170BF2: ???
==30400==    by 0x817B1D8: ???
==30400==    by 0x817B102: ???
==30400==    by 0x817B08F: ???
==30400==    by 0x52904BA: operations_research::GetGurobiEnv() (in /usr/local/lib/libortools.so.9.7.2996)
==30400==    by 0x12D023: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30400== 
==30400== LEAK SUMMARY:
==30400==    definitely lost: 37,823 bytes in 4 blocks
==30400==    indirectly lost: 313,741 bytes in 39 blocks
==30400==      possibly lost: 64 bytes in 2 blocks
==30400==    still reachable: 75,756 bytes in 527 blocks
==30400==         suppressed: 0 bytes in 0 blocks
==30400== Reachable blocks (those to which a pointer was found) are not shown.
==30400== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==30400== 
==30400== For lists of detected and suppressed errors, rerun with: -s
==30400== ERROR SUMMARY: 6 errors from 6 contexts (suppressed: 0 from 0)


# Interior Point


==30675== 
==30675== HEAP SUMMARY:
==30675==     in use at exit: 427,337 bytes in 571 blocks
==30675==   total heap usage: 61,274 allocs, 60,703 frees, 156,130,290 bytes allocated
==30675== 
==30675== 24 bytes in 1 blocks are definitely lost in loss record 22 of 135
==30675==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30675==    by 0x4E98826: File::Open(char const*, char const*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x4E98B4B: file::Open(std::basic_string_view<char, std::char_traits<char> > const&, std::basic_string_view<char, std::char_traits<char> > const&, File**, int) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5302395: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x530225B: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x52F3310: operations_research::glop::MpsFileToMPModelProto(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x12C630: operations_research::loadMPSFile(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675==    by 0x12CFB6: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675== 
==30675== 24 bytes in 1 blocks are definitely lost in loss record 23 of 135
==30675==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30675==    by 0x4E98826: File::Open(char const*, char const*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x4E98B4B: file::Open(std::basic_string_view<char, std::char_traits<char> > const&, std::basic_string_view<char, std::char_traits<char> > const&, File**, int) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5302395: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5302291: operations_research::MPSReaderTemplate<operations_research::glop::DataWrapper<operations_research::MPModelProto> >::ParseFile(std::basic_string_view<char, std::char_traits<char> >, operations_research::glop::DataWrapper<operations_research::MPModelProto>*, operations_research::MPSReaderFormat) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x52F3310: operations_research::glop::MpsFileToMPModelProto(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x12C630: operations_research::loadMPSFile(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&) (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675==    by 0x12CFB6: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675== 
==30675== 32 bytes in 1 blocks are possibly lost in loss record 32 of 135
==30675==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30675==    by 0x5749769: google::protobuf::internal::ArenaStringPtr::Mutable[abi:cxx11](google::protobuf::Arena*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x579C4C3: google::protobuf::FileOptions::_InternalParse(char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x583469D: bool google::protobuf::internal::MergeFromImpl<false>(std::basic_string_view<char, std::char_traits<char> >, google::protobuf::MessageLite*, google::protobuf::MessageLite::ParseFlags) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5786325: void google::protobuf::DescriptorBuilder::AllocateOptionsImpl<google::protobuf::FileDescriptor>(std::basic_string_view<char, std::char_traits<char> >, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::FileDescriptor::OptionsType const&, google::protobuf::FileDescriptor*, std::vector<int, std::allocator<int> > const&, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5768B02: google::protobuf::DescriptorBuilder::AllocateOptions(google::protobuf::FileOptions const&, google::protobuf::FileDescriptor*, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5770836: google::protobuf::DescriptorBuilder::BuildFileImpl(google::protobuf::FileDescriptorProto const&, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5771F35: google::protobuf::DescriptorBuilder::BuildFile(google::protobuf::FileDescriptorProto const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5772CA8: google::protobuf::DescriptorPool::BuildFileFromDatabase(google::protobuf::FileDescriptorProto const&) const (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5773006: google::protobuf::DescriptorPool::TryFindFileInFallbackDatabase(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x577338D: google::protobuf::DescriptorPool::FindFileByName(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x57D41C5: google::protobuf::(anonymous namespace)::AssignDescriptorsImpl(google::protobuf::internal::DescriptorTable const*, bool) (in /usr/local/lib/libortools.so.9.7.2996)
==30675== 
==30675== 32 bytes in 1 blocks are possibly lost in loss record 33 of 135
==30675==    at 0x483BE63: operator new(unsigned long) (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30675==    by 0x69A738D: std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_mutate(unsigned long, unsigned long, char const*, unsigned long) (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28)
==30675==    by 0x69A7EBF: std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_M_replace_aux(unsigned long, unsigned long, unsigned long, char) (in /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.28)
==30675==    by 0x583717C: google::protobuf::internal::InlineGreedyStringParser(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x579C4D1: google::protobuf::FileOptions::_InternalParse(char const*, google::protobuf::internal::ParseContext*) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x583469D: bool google::protobuf::internal::MergeFromImpl<false>(std::basic_string_view<char, std::char_traits<char> >, google::protobuf::MessageLite*, google::protobuf::MessageLite::ParseFlags) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5786325: void google::protobuf::DescriptorBuilder::AllocateOptionsImpl<google::protobuf::FileDescriptor>(std::basic_string_view<char, std::char_traits<char> >, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::FileDescriptor::OptionsType const&, google::protobuf::FileDescriptor*, std::vector<int, std::allocator<int> > const&, std::basic_string_view<char, std::char_traits<char> >, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5768B02: google::protobuf::DescriptorBuilder::AllocateOptions(google::protobuf::FileOptions const&, google::protobuf::FileDescriptor*, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5770836: google::protobuf::DescriptorBuilder::BuildFileImpl(google::protobuf::FileDescriptorProto const&, google::protobuf::internal::FlatAllocator&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5771F35: google::protobuf::DescriptorBuilder::BuildFile(google::protobuf::FileDescriptorProto const&) (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5772CA8: google::protobuf::DescriptorPool::BuildFileFromDatabase(google::protobuf::FileDescriptorProto const&) const (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x5773006: google::protobuf::DescriptorPool::TryFindFileInFallbackDatabase(std::basic_string_view<char, std::char_traits<char> >) const (in /usr/local/lib/libortools.so.9.7.2996)
==30675== 
==30675== 351,469 (37,728 direct, 313,741 indirect) bytes in 1 blocks are definitely lost in loss record 135 of 135
==30675==    at 0x483DD99: calloc (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
==30675==    by 0x8170BF2: ???
==30675==    by 0x817B1D8: ???
==30675==    by 0x817B102: ???
==30675==    by 0x817B08F: ???
==30675==    by 0x52904BA: operations_research::GetGurobiEnv() (in /usr/local/lib/libortools.so.9.7.2996)
==30675==    by 0x12D023: operations_research::solveGurobi() (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675==    by 0x12D8A5: main (in /home/john/repos/homework/me5414/or_tools/myapp)
==30675== 
==30675== LEAK SUMMARY:
==30675==    definitely lost: 37,776 bytes in 3 blocks
==30675==    indirectly lost: 313,741 bytes in 39 blocks
==30675==      possibly lost: 64 bytes in 2 blocks
==30675==    still reachable: 75,756 bytes in 527 blocks
==30675==         suppressed: 0 bytes in 0 blocks
==30675== Reachable blocks (those to which a pointer was found) are not shown.
==30675== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==30675== 
==30675== For lists of detected and suppressed errors, rerun with: -s
==30675== ERROR SUMMARY: 5 errors from 5 contexts (suppressed: 0 from 0)
