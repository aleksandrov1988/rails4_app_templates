module CopyrightHelper
  def copyright_years
    year1=2013
    year2=Date.today.year
    res="© #{t('app.name')}, "
    res+=year1==year2 ? "#{year1}" : "#{year1}–#{year2}"
    content_tag(:span, res)
  end
end
