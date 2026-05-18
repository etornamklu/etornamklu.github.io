---
layout: default
title: Reflections
---

# Reflections

Things I'm thinking through. Sometimes a technical concept, sometimes not. The common thread is that something made me stop and sit with it longer than expected.

---

{% for post in site.categories.reflections %}
  <div>
    <span class="post-meta">{{ post.date | date: "%Y-%m-%d" }}</span>
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  </div>
{% endfor %}
