program allocate_benchmark
  implicit none

  integer, parameter    :: dp           = kind(0.0d0)
  integer, parameter    :: n_allocs     = 2**10
  integer, parameter    :: total_size   = 2**28
  integer, parameter    :: partial_size = total_size / n_allocs
  integer               :: n
  real(dp)              :: t0, t1
  real(dp), allocatable :: one_array(:)

  type block_t
     real(dp), allocatable :: d(:)
  end type block_t

  type(block_t), allocatable :: list_of_arrays(:)

  call cpu_time(t0)
  allocate(list_of_arrays(n_allocs))
  do n = 1, n_allocs
     allocate(list_of_arrays(n)%d(partial_size))
     list_of_arrays(n)%d(:) = 1.0_dp
  end do
  call cpu_time(t1)
  write(*, "(A20,E11.2)") "list of arrays (s)", t1 - t0

  call cpu_time(t0)
  allocate(one_array(total_size))
  one_array(:) = 1.0_dp
  call cpu_time(t1)
  write(*, "(A20,E11.2)") "one array (s)", t1 - t0

end program allocate_benchmark
