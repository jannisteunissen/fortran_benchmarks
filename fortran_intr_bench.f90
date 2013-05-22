program fortran_intr_bench
   integer, parameter :: dp = kind(0.0d0)
   integer, parameter :: test_size = 20*1000*1000

   integer :: nn
   real(dp), allocatable :: input_values(:)
   real(dp) :: time_start, time_end
   real(dp) :: sum_result

   ! Don't put these values on the stack due to size restrictions on some system
   allocate(input_values(test_size))
   do nn = 1, test_size
      input_values(nn) = 0.25_dp * (nn-1.0_dp)/(test_size-1.0_dp) + 0.25_dp
   end do

   write(*, *) "Fortran (floating point) intrinsics benchmark"
   write(*, *) ""
   write(*, *) "*There is a slight overhead (not just pure calls),"
   write(*, *) "which is estimated at the first entry"
   write(*, *) ""
   write(*, *) "*These results are computed with input in the range 0.25-0.75,"
   write(*, *) "in a different range the intrinsics can be faster or slower"
   write(*, *) ""

   write(*, "(A,I0,A)") " Calling each routine ", test_size, " times"

   write(*, *) ""
   write(*, "(A,I0,A)") " intrinsic | ns per call"
   write(*, *) "---------------------------------"

   ! To prevent the compiler from optimizing intructions out, their sum is computed
   sum_result = 0.0_dp

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + input_values(nn)
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "overhead |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + 1.337_dp * input_values(nn)
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "multiply |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + 1 / input_values(nn)
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "division |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + sin(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "sin |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + cos(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "cos |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + tan(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "tan |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + sinh(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "sinh |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + cosh(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "cosh |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + tanh(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "tanh |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + asin(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "asin |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + acos(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "acos |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + atan(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "atan |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + atan2(input_values(nn), input_values(test_size-nn+1))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "atan2 |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + sqrt(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "sqrt |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + exp(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "exp |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + log(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "log |", (time_end - time_start) * 1e9_dp / test_size

   call cpu_time(time_start)
   do nn = 1, test_size
      sum_result = sum_result + log10(input_values(nn))
   end do
   call cpu_time(time_end)
   write(*, "(A12,F11.2)") "log10 |", (time_end - time_start) * 1e9_dp / test_size

   write(*, *) "---------------------------------"
   write(*, *) ""
   write(*, "(A,E11.4)") " Done! The sum of all computed values is: ", sum_result

end program fortran_intr_bench
