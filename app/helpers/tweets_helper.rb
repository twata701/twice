# coding: utf-8
module TweetsHelper
  def ymconv(yyyymm,cnt)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    
    return yyyy + "年" + mm + "月 (" + cnt + ")"
  end
end
