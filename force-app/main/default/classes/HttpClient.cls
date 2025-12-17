public with sharing class HttpClient {
    private String namedCredentials;
    private String endpoint;
    private Map<String,String> headers;
    private Integer timeout;

    public HttpClient(String namedCredentials , String endpoint) {
        this.namedCredentials = namedCredentials;
        this.endpoint = endpoint;
        this.headers = new Map<String,String>();
        this.timeout = 120000;
    }
    public HttpResponse get(){
       return send('GET',null);
    }
    
    private HttpResponse send(String method , String body){
        HttpRequest request = buildHttpRequest(method, body);
        Http http = new Http();
        return http.send(request);

    }

    private HttpRequest buildHttpRequest(String method,String body){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('Callout:' + namedCredentials + endpoint);
        request.setMethod(method);
        if(body != null){
            request.setBody(body);
        }

        for(String key : headers.keySet()){
            request.setHeader(key, headers.get(key));
        }
        return request;
    }

    public HttpClient setHeaders(String key , String value){
        this.headers.put(key,value);
        return this;
    }

    public HttpClient setTimeout(Integer timeout){
        this.timeout = timeout;
        return this;
    }
    




}