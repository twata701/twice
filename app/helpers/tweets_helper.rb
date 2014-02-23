# coding: utf-8
module TweetsHelper
  def ymconv(yyyymm,cnt=nil)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    
    if cnt == nil
      return yyyy + "年" + mm + "月 "
    else
      return yyyy + "年" + mm + "月 (" + cnt + ")"
    end
    
  end
end
