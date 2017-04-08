runtime! plugin/doorboy.vim

source spec_helper.vim

describe 'brackts'
  after
    normal ggdG
  end

  context 'when no characters in the current line'
    " ()
    context 'and putting (#'
      it 'should put ( twice'
        call spec_helper#insert_chars('(#')
        Expect getline(1) == '(#)'
      end
    end

    " {}
    context 'and putting {#'
      it 'should put { twice'
        call spec_helper#insert_chars('{#')
        Expect getline(1) == '{#}'
      end
    end

    " []
    context 'and putting [#'
      it 'should put [ twice'
        call spec_helper#insert_chars('[#')
        Expect getline(1) == '[#]'
      end
    end
  end

  context 'when cursor is in front of opening bracket'
    before
      call spec_helper#put_with_cursor('|()')
    end

    context 'and putting (SKIP'
      it 'should skip'
        call spec_helper#insert_chars('(SKIP')
        Expect getline(1) == '(SKIP)'
      end
    end
  end

  context 'when cursor is in front of word character'
    before
      call spec_helper#put_with_cursor('|"text"')
    end

    context 'and putting ('
      it 'should put ( once'
        call spec_helper#insert_chars('(')
        Expect getline(1) == '("text"'
      end
    end
  end

  context 'when cursor is in front of separator character'
    before
      call spec_helper#put_with_cursor('|,')
    end

    context 'and putting ('
      it 'should put ( twice'
        call spec_helper#insert_chars('(')
        Expect getline(1) == '(),'
      end
    end
  end

  context 'when cursor is between brackets'
    before
      call spec_helper#put_with_cursor('(|)')
    end

    context 'and pressing backspace'
      it 'should delete brackets'
        call spec_helper#insert_bs()
        Expect getline(1) == ''
      end
    end

    context 'and pressing close bracket'
      it 'should skip out of brackets'
        call spec_helper#insert_chars(')')
        Expect getline(1) == '()'
      end
    end

    context 'and pressing space'
      it 'should push brackets away'
        call spec_helper#insert_chars(' here')
        Expect getline(1) == '( here )'
      end
    end

    context 'and pressing cr'
      it 'should push out the closing bracket'
        call spec_helper#insert_cr()
        Expect getline(1) == '('
        Expect getline(2) == "\t"
        Expect getline(3) == ')'
      end
    end
  end

  context 'when cursor is between brackets with spacing'
    before
      call spec_helper#put_with_cursor('{ | }')
    end

    context 'and pressing backspace'
      it 'should delete both sides of space'
        call spec_helper#insert_bs()
        Expect getline(1) == '{}'
      end
    end
  end
end
