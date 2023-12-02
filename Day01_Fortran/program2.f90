program program
  implicit none

  integer :: ZeroChar, NineChar
  integer :: TRUE = 1
  integer :: FALSE = 0

  integer :: sum, file, lineCount, IERR
  character*256, allocatable :: content(:)
  character*256 :: CTMP
  integer :: i 
  
  ZeroChar = 48
  NineChar = 57
  sum = 0

  open(unit = file, FILE='input1.txt')

  ! number of lines
  do while(IERR == 0)
    lineCount = lineCount + 1
    read(file, *, iostat=IERR) CTMP
  end do
  lineCount= lineCount - 1
  print *, lineCount

  ! allocate memory
  allocate(content(lineCount))

  ! read file content into memory
  rewind(file)
  do i = 1, lineCount
    read(file, '(A)') content(i)
  end do

  ! printing arrays
  do i = 1, lineCount
    call parseLine(content(i))
    print *, sum
  end do

  deallocate(content)
  close(file)

  contains

  subroutine parseLine(line)
    implicit none

    integer :: first, second, i, num
    character*256 :: line
    character*3 :: threeSubstring
    character*4 :: fourSubstring
    character*5 :: fiveSubstring
    character :: singleChar
    integer :: charASCII, firstNumberSet
    integer :: result

    print *, line
    firstNumberSet = FALSE

    do i = 1, 256
      singleChar = line(i:i)
      charASCII = iachar(singleChar)

      ! print *, charASCII
      if (charASCII .ge. ZeroChar .and. charASCII .le. NineChar) then
        num = charASCII - ZeroChar
        call updateFirstAndSecond(num, first, second, firstNumberSet)
      end if

      threeSubstring = line(i:i+3)
      fourSubstring = line(i:i+4)
      fiveSubstring = line(i:i+5)

      select case (threeSubstring)
        case('one') 
          call updateFirstAndSecond(1, first, second, firstNumberSet)
          
        case('two')
          call updateFirstAndSecond(2, first, second, firstNumberSet)
          
        case('six')
          call updateFirstAndSecond(6, first, second, firstNumberSet)
      end select

      select case (fourSubstring)
        case('four')
          call updateFirstAndSecond(4, first, second, firstNumberSet)
          
        case('five')
          call updateFirstAndSecond(5, first, second, firstNumberSet)
          
        case('nine')
          call updateFirstAndSecond(9, first, second, firstNumberSet)
      end select

      select case (fiveSubstring)
        case('three')
          call updateFirstAndSecond(3, first, second, firstNumberSet)
          
        case('seven')
          call updateFirstAndSecond(7, first, second, firstNumberSet)
          
        case('eight')
          call updateFirstAndSecond(8, first, second, firstNumberSet)
      end select
    end do

    print *, first * 10 + second
    sum = first * 10 + second + sum
  end subroutine parseLine

  subroutine updateFirstAndSecond(num, first, second, firstNumberSet)
    integer :: num, first, second, firstNumberSet

    if (firstNumberSet .eq. FALSE) then
      firstNumberSet = TRUE
      first = num
      second = num
    else 
      second = num
    end if

  end subroutine updateFirstAndSecond

end program program