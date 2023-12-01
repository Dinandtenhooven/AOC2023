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

    integer :: first, second, i
    character*256 :: line
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

        if (firstNumberSet .eq. FALSE) then
          firstNumberSet = TRUE
          first = charASCII - ZeroChar
          second = charASCII - ZeroChar
        else 
          second = charASCII - ZeroChar
        end if
      end if
    end do

    result = first * 10 + second
    print *, result
    sum = sum + result

  end subroutine parseLine

end program program