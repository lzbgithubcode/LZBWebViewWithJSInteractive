# LZBWebViewWithJSInteractive
webView与JS交互的方法总结

JS与OC交互的类别
第一 ：JS调用OC的方法
1、采用传统的方法，加载WebView的时候截取URL的方式

2、利用苹果系统框架<JavaScriptCore/JavaScriptCore.h>的JSContext的block方式 或者JSExport协议方式

第二：OC调用JS的方法
1、采用stringByEvaluatingJavaScriptFromString写入JS代码，调用JS的方法

2、采用系统框架<JavaScriptCore/JavaScriptCore.h>的JSContext +evaluateScript调用JS代码

详细解说请参考简书地址：

#JS与OC交互大总结之一 JS调用OC (http://www.jianshu.com/p/b9bba225a87f)
#JS与OC交互大总结之二 OC调用JS (http://www.jianshu.com/p/4e45fb277461)
