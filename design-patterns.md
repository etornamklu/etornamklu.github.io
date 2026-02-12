---
layout: default
title: Design Patterns
---

# Design Patterns

{% for post in site.categories.design-patterns %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}