module m_simple_routines

  implicit none
  public

  abstract interface
     subroutine subr_x_t(x)
       import
       integer, intent(inout)  :: x
     end subroutine subr_x_t
  end interface

contains

  subroutine sub_a(x)
    integer, intent(inout)  :: x
    x = x + 1
  end subroutine sub_a

  subroutine sub_b(x)
    integer, intent(inout)  :: x
    x = x + 2
  end subroutine sub_b

  subroutine sub_c(x)
    integer, intent(inout)  :: x
    x = x + 3
  end subroutine sub_c

end module m_simple_routines
