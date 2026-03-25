---
layout: default
title: Everything Else
---

# Everything Else

{% for post in site.categories.everything-else %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}