package ronin

uses javax.servlet.http.HttpServletRequest

enhancement HttpServletRequestEnhancement: HttpServletRequest {

  /**
   *  The servlet's root URL.
   */
  property get RootURL() : String {
    if (this.ServerPort == 80 or this.ServerPort == 443) {
      return "${this.Scheme}://${this.ServerName}${this.ContextPath}"
    } else {
      return "${this.Scheme}://${this.ServerName}:${this.ServerPort}${this.ContextPath}"
    }
  }

  /**
   *  The full URL of the request.
   */
  property get FullURL() : String {
    return this.RequestURL.append(this.QueryString == null ? "" : "?${this.QueryString}").toString()
  }
}