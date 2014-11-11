module ApplicationHelper
    def title(title)
        content_for :title, title
    end
    def page_title
        if content_for? :title
            "Flix - #{content_for(:title)}"
        else
            "Flix"
        end
    end
    def nav_link_to(title, url)
        classes = %w(button)

        classes << :active if current_page? url

        link_to title, url, class: classes.join(' ')
    end
end
