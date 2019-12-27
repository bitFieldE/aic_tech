module ApplicationHelper
  def page_title
    title = "AIC⚤TECH"
    title = @page_title + "-" + title if @page_title
    return title
  end

  # メニューバーのリンク表示に使う
  def menu_link_to(text, path, options = {})
    link_to_unless_current(text, path, options) do
      content_tag(:a, text, style: "pointer-events: none; color: rgb(169, 169, 169);")
    end
  end
end
