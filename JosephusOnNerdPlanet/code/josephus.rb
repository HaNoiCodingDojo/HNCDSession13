require 'test/unit'

class Josephus
  
  def initialize(args)
    @n = args[:n]
    @m = args[:m]
    @k = args[:k]
  end

  def findWinner
    day = (1..@n).to_a
    bat_dau = 1
    (@n-1).times do
      ra_di = xacDinhMTinhTuI({:m => @m + bat_dau % @k,
                               :i => bat_dau % day.size + 1},
                              day)
      vi_cua_thang_ra_di = day.index(ra_di)
      puts day.to_s
      day = loaiBoPhanTuThuI(vi_cua_thang_ra_di+1,day)
      bat_dau = vi_cua_thang_ra_di + 1
    end
    day[0]
  end
end

def xacdinhsothumtinhtu1(m, day) 
  xacDinhMTinhTuI({:m => m, :i => 1}, day)
end

def xacDinhMTinhTuI(mi, day)
  day[(mi[:m]-1  + mi[:i]-1) % day.size]
end

def loaiBoPhanTuThuI(i, day)
  # day = day[0:(i-1)] + day[i:]
  day.delete_at(i - 1)
  day
end

class TestJosephus < Test::Unit::TestCase
  
   def test_nIs6mIs3kIs2
     assert_equal( 3,  
                   Josephus.new({:n => 3,:m => 1, :k =>1}).findWinner())
     assert_equal( 5,
                   Josephus.new({:n => 6,:m => 3, :k =>2}).findWinner())
    
     assert_equal( 3,
                   Josephus.new({:n => 3,:m => 1, :k =>1}).findWinner())
   end

  def test_xacdinhsothumtinhtu1
    assert_equal(1, xacdinhsothumtinhtu1(1, [1, 2, 3, 4]))
    assert_equal(2, xacdinhsothumtinhtu1(2, [1, 2, 3, 4]))
    assert_equal(1, xacdinhsothumtinhtu1(5, [1, 2, 3, 4]))
    assert_equal(10, xacdinhsothumtinhtu1(7, [11, 2, 10, 4]))
  end

  def test_XacDinhSoThuMTinhTuI
    assert_equal(1, xacDinhMTinhTuI({:m => 1, :i => 1},
                                    [1, 2, 3, 4, 5]))
    assert_equal(2, xacDinhMTinhTuI({:m => 1, :i => 2},
                                    [1, 2, 3, 4, 5]))
    assert_equal(3, xacDinhMTinhTuI({:m => 2, :i => 2},
                                    [1, 2, 3, 4, 5]))
    assert_equal(2, xacDinhMTinhTuI({:m => 6, :i => 2},
                                    [1, 2, 3, 4, 5]))
  end
  def test_loaiBoPhanTuThuI
    assert_equal([2, 3, 4], loaiBoPhanTuThuI(1, [1, 2, 3, 4]))
  end
end
