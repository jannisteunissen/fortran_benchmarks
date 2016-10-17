! This program benchmarks function pointers vs if statements
program function_pointer_benchmark
  use m_simple_routines

  implicit none

  integer, parameter           :: test_size    = 100*1000*1000
  integer, parameter           :: dp           = kind(0.0d0)
  real(dp)                     :: time_start, time_end, random_real
  integer                      :: i_method, sum, n, run
  procedure(subr_x_t), pointer :: my_procedure => null()

  ! Choose method
  call random_number(random_real)
  i_method = floor(3 * random_real) + 1

  ! Set procedure pointer
  if (i_method == 1) then
     my_procedure => sub_a
  else if (i_method == 2) then
     my_procedure => sub_b
  else
     my_procedure => sub_c
  end if

  do run = 1, 5
     print *, "****************************************"
     print *, "Run", run
     print *, "****************************************"

     sum = 0
     call cpu_time(time_start)

     do n = 1, test_size
        call my_procedure(sum)
     end do

     call cpu_time(time_end)
     write(*, "(A30,F11.2,A)") "Time per call (proc. pointer): ", &
          (time_end - time_start) * 1e9_dp / test_size, " ns"
     write(*, "(A30,I11.2)") "Sum: ", sum

     sum = 0
     call cpu_time(time_start)

     do n = 1, test_size
        if (i_method == 1) then
           call sub_a(sum)
        else if (i_method == 2) then
           call sub_b(sum)
        else
           call sub_c(sum)
        end if
     end do

     call cpu_time(time_end)
     write(*, "(A30,F11.2,A)") "Time per call (if statement): ", &
          (time_end - time_start) * 1e9_dp / test_size, " ns"
     write(*, "(A30,I11.2)") "Sum: ", sum
  end do

end program function_pointer_benchmark
