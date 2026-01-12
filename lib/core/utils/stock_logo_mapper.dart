class StockLogoMapper {
  static final Map<String, String> _symbolToDomain = {
    'RELIANCE': 'ril.com',
    'TCS': 'tcs.com',
    'HDFCBANK': 'hdfcbank.com',
    'INFY': 'infosys.com',
    'HINDUNILVR': 'hul.co.in',
    'ITC': 'itcportal.com',
    'SBIN': 'sbi.co.in',
    'BHARTIARTL': 'airtel.in',
    'LICI': 'licindia.in',
    'BAJFINANCE': 'bajajfinserv.in',
    'KOTAKBANK': 'kotak.com',
    'LT': 'larsentoubro.com',
    'HCLTECH': 'hcltech.com',
    'ASIANPAINT': 'asianpaints.com',
    'AXISBANK': 'axisbank.com',
    'MARUTI': 'marutisuzuki.com',
    'TITAN': 'titan.co.in',
    'SUNPHARMA': 'sunpharma.com',
    'ULTRACEMCO': 'ultratechcement.com',
    'WIPRO': 'wipro.com',
    'ONGC': 'ongcindia.com',
    'NTPC': 'ntpc.co.in',
    'POWERGRID': 'powergrid.in',
    'TATAMOTORS': 'tatamotors.com',
    'ADANIENT': 'adanienterprises.com',
    'M&M': 'mahindra.com',
    'JSWSTEEL': 'jsw.in',
    'TATASTEEL': 'tatasteel.com',
    'COALINDIA': 'coalindia.in',
    'ADANIPORTS': 'adaniports.com',
    'BAJAJFINSV': 'bajajfinserv.in',
    'HDFCLIFE': 'hdfclife.com',
    'GRASIM': 'grasim.com',
    'CIPLA': 'cipla.com',
    'DIVISLAB': 'divislabs.com',
    'SBILIFE': 'sbilife.co.in',
    'DRREDDY': 'drreddys.com',
    'BRITANNIA': 'britannia.co.in',
    'TECHM': 'techmahindra.com',
    'HINDALCO': 'hindalco.com',
    'EICHERMOT': 'eichermotors.com',
    'TATACONSUM': 'tataconsumer.com',
    'APOLLOHOSP': 'apollohospitals.com',
    'HEROMOTOCO': 'heromotocorp.com',
    'UPL': 'upl-ltd.com',
    'INDUSINDBK': 'indusind.com',
    'BPCL': 'bharatpetroleum.in',
  };

  static String getLogoUrl(String symbol) {
    // If API provided a generic URL inside the symbol (rare/not implemented yet), use it.
    // Otherwise, generate using Google Favicons (more reliable than Clearbit)
    final domain =
        _symbolToDomain[symbol.toUpperCase()] ?? '${symbol.toLowerCase()}.com';
    return 'https://www.google.com/s2/favicons?domain=$domain&sz=128';
  }
}
