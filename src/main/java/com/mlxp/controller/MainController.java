package com.mlxp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mlxp.dto.HighChartsData;
import com.mlxp.dto.VisitMessage;
import com.mlxp.service.ArticleService;
import com.mlxp.service.ArticleTypeService;
import com.mlxp.service.AttachmentService;
import com.mlxp.service.UserService;
import com.mlxp.service.ViewLogService;
import com.mlxp.util.CookieUtil;
import com.mlxp.util.DateUtil;

@Controller
@RequestMapping("/main")
public class MainController {

    @Autowired
    private UserService userService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private ViewLogService viewLogService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private ArticleTypeService articleTypeService;

    @RequestMapping(value = "/index")
    private String main(HttpServletRequest request) {
        request.setAttribute("currentuser", CookieUtil.getValue(request, "currentuser"));
        return "blog/main";
    }

    @RequestMapping(value = "/up")
    private String up() {
        return "test/up";
    }

    @RequestMapping(value = "/loading")
    private String loading() {
        return "test/loading";
    }

    @RequestMapping(value = "/high")
    private String high() {
        return "test/highcharts";
    }

    @RequestMapping(value = "/getcharts")
    @ResponseBody
    private List<HighChartsData> getCharts() {
        List<String> datelist = DateUtil.getOtherDayList(30);
        List<VisitMessage> uvlist = viewLogService.countNDays(0, 30);
        List<VisitMessage> pvlist = viewLogService.countNDays(1, 30);
        int i = 0;
        int k = 0;
        List<Integer> uv_data_list = new ArrayList<Integer>();
        List<Integer> pv_data_list = new ArrayList<Integer>();
        for (String str : datelist) {
            if (i <= pvlist.size() - 1 && str.equals(pvlist.get(i).getVisitTime())) {
                pv_data_list.add(pvlist.get(i).getCount());
                i++;
            } else {
                pv_data_list.add(0);
            }
            if (k <= uvlist.size() - 1 && str.equals(uvlist.get(k).getVisitTime())) {
                uv_data_list.add(uvlist.get(k).getCount());
                k++;
            } else {
                uv_data_list.add(0);
            }
        }
        HighChartsData uv_hcd = new HighChartsData("访问用户（UV）", uv_data_list);
        HighChartsData pv_hcd = new HighChartsData("访问量（PV）", pv_data_list);
        List<HighChartsData> result = new ArrayList<HighChartsData>();
        result.add(uv_hcd);
        result.add(pv_hcd);
        return result;
    }

    @RequestMapping(value = "/dashboard")
    private String dashboard(Model model) {
        Integer pv = viewLogService.countAll(1);
        Integer lastpv = viewLogService.countNDaysBefore(1, 1);
        Integer uv = viewLogService.countAll(0);
        Integer lastuv = viewLogService.countNDaysBefore(0, 1);
        Integer liked = articleService.countAllLiked();
        Integer hits = articleService.countAllHits();
        Integer articles = articleService.countAll();
        Integer types = articleTypeService.countAll();
        model.addAttribute("pv", pv);
        model.addAttribute("lastpv", lastpv);
        model.addAttribute("uv", uv);
        model.addAttribute("lastuv", lastuv);
        model.addAttribute("liked", liked);
        model.addAttribute("hits", hits);
        model.addAttribute("articles", articles);
        model.addAttribute("types", types);
        return "blog/dashboard";
    }

    @RequestMapping(value = "/getVisitMessage")
    @ResponseBody
    private String getVisitMessage() {
        List<String> datelist = DateUtil.getOtherDayList(30);
        List<VisitMessage> uvlist = viewLogService.countNDays(0, 30);
        List<VisitMessage> pvlist = viewLogService.countNDays(1, 30);
        int i = 0;
        int k = 0;
        StringBuffer sb = new StringBuffer();
        sb.append("Day,访问量（PV）,访问用户（UV）\n");
        for (String str : datelist) {
            sb.append(str + ",");
            if (str.equals(pvlist.get(i).getVisitTime())) {
                sb.append(pvlist.get(i).getCount() + ",");
                i++;
            } else {
                sb.append("0,");
            }
            if (str.equals(uvlist.get(k).getVisitTime())) {
                sb.append(uvlist.get(k).getCount() + "\n");
                k++;
            } else {
                sb.append("0\n");
            }
        }
        System.out.println(sb);
        return sb.toString();
    }
}
