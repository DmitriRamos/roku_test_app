sub init()
    m.top.functionname = "request"
    m.top.response = ""
  end sub
  
  function request()
      url = m.top.url
      http = createObject("roUrlTransfer")
      http.RetainBodyOnError(true)
      port = createObject("roMessagePort")
      http.setPort(port)
      http.setCertificatesFile("common:/certs/ca-bundle.crt")
      http.InitClientCertificates()
      http.enablehostverification(false)
      http.enablepeerverification(false)
      http.setUrl(url)
      if http.AsyncGetToString() Then
        msg = wait(10000, port)
        if (type(msg) = "roUrlEvent")
          'HTTP response code can be <0 for Roku-defined errors
          if (msg.GetResponseCode() > 0 and  msg.GetResponseCode() < 400)
            m.top.response = msg.GetString()
          else
            m.top.error = "Feed failed to load. "+ chr(10) + msg.getfailurereason() + chr(10) + "Code: "+msg.GetResponseCode().toStr()+ chr(10) + "URL: "+ m.top.url
          end if
          http.asynccancel()
        else if (msg = invalid)
          ?
          m.top.error = "Feed failed to load. Uknown reason."
          http.asynccancel()
        end if
      end if
      return 0
  end function