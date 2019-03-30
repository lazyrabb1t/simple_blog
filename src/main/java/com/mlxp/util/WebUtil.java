package com.mlxp.util;

import java.text.SimpleDateFormat;
import java.util.List;

import com.mlxp.define.HalalaDefine;
import com.mlxp.model.Article;
import com.mlxp.model.Attachment;
import com.mlxp.service.AttachmentService;

public class WebUtil {

    private WebUtil() {
    }

    /**
     * 提取富文本中内容
     * 
     * @param: @param list 文章列表
     * @param: @param length 文本长度
     * @param: @return
     */
    public static List<Article> getContent(List<Article> list, int length) {
        int i = 0;
        String content = "";
        SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy HH:mm:ss");
        for (Article article : list) {
            if (article.getContent() != null) {
                content = article.getContent().replaceAll("<.*?>", "").replace("&nbsp;", "");
                if (content.length() > length) {
                    content = content.substring(0, length) + " ...... ";
                }
                list.get(i).setContent(content);
            }
            if (article.getUpdateTime() != null) {
                list.get(i).setStringTime(sdf.format(article.getUpdateTime()));
            }
            i++;
        }
        return list;
    }

    /**
     * 返回文章列表的图片
     * 
     * @param: @param list
     * @param: @param attachmentService
     * @param: @return
     */
    public static List<Article> getAttachments(List<Article> list, AttachmentService attachmentService) {
        for (int i = 0; i < list.size(); i++) {
            Attachment tempAttachment = attachmentService.selectByOrigin(list.get(i).getArticleId(), HalalaDefine.ARTICLE_ATTACHMENT_TYPE);
            list.get(i).setAttachment(tempAttachment);
        }
        return list;
    }

    /**
     * 代码高亮显示
     */
    public static String syntaxCode(String content) {
        // 代码高亮显示
        // <pre><code class="lang-java"></code></pre> -> <pre class="syntax
        // java"></pre>
        return content.replaceAll("<pre><code class=\"lang-", "<pre><code class=\"syntax ").replaceAll("<pre><code>", "<pre><code class=\"syntax\">")
                .replaceAll("<pre><code", "<pre").replaceAll("</code></pre>", "</pre>");
    }
}
