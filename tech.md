---
layout: default
title: Tech
---

# Tech

{% for post in site.categories.tech %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}