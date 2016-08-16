! This program benchmarks select case constructs for integers and strings
program select_case_benchmark

  integer, parameter                     :: test_size  = 20*1000*1000
  integer, parameter                     :: dp         = kind(0.0d0)
  integer, parameter                     :: string_len = 10
  integer                                :: k, sum
  integer, allocatable                   :: int_list(:)
  character(len=string_len), allocatable :: string_list(:)
  real(dp)                               :: time_start, time_end

  allocate(int_list(test_size))
  allocate(string_list(test_size))

  ! Initialize arrays with values from 1 to 3, either as integers or as strings
  do n = 1, test_size
     k           = modulo(n, 3) + 1
     int_list(n) = k

     select case (k)
     case (1)
        string_list(n) = "one"
     case (2)
        string_list(n) = "two"
     case (3)
        string_list(n) = "three"
     end select
  end do

  sum = 0
  call cpu_time(time_start)

  do n = 1, test_size
     select case (int_list(n))
     case (1)
        sum = sum + 1
     case (2)
        sum = sum + 2
     case (3)
        sum = sum + 3
     end select
  end do

  call cpu_time(time_end)
  write(*, "(A30,F11.2,A)") "Time per select (integer): ", &
       (time_end - time_start) * 1e9_dp / test_size, " ns"
  write(*, "(A30,I11.2)") "Sum: ", sum

  sum = 0
  call cpu_time(time_start)

  do n = 1, test_size
     select case (string_list(n))
     case ("one")
        sum = sum + 1
     case ("two")
        sum = sum + 2
     case ("three")
        sum = sum + 3
     end select
  end do

  call cpu_time(time_end)
  write(*, "(A30,F11.2,A)") "Time per select (string): ", &
       (time_end - time_start) * 1e9_dp / test_size, " ns"
  write(*, "(A30,I11.2)") "Sum: ", sum

end program select_case_benchmark
