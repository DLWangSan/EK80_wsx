function mtime=NTTime2Mlab(NTTime)
% NTTime2Mlab - converts from NT time to matlab serial time as returned from datenum
%   mtime=NTTime2Mlab(NTTime) - Converts the NTTime vector containing time in NT format
%                               to matlab serial time.Output can be used directly into datestr
% Ruben Patel IMR
    
    
    import java.util.GregorianCalendar;
    import java.util.TimeZone;
    import java.text.SimpleDateFormat;
    import java.sql.Timestamp;
    
    cal = GregorianCalendar;
    
    NT_START_CAL=GregorianCalendar(1601, 0, 1);
    GMT = TimeZone.getTimeZone('GMT');
    NT_START_CAL.setTimeZone(GMT);
    NT_START_DATE= -11644473600000.0;%NT_START_CAL.get(NT_START_CAL.MILLISECOND);
    OUT_DATE_FORMAT = SimpleDateFormat('dd-MMM-yyyy HH:mm:ss');
    OUT_DATE_FORMAT.setTimeZone(GMT);
    for i=1:length(NTTime)
      mlabMilli=(NTTime(i)/10000.0)+NT_START_DATE;  
      date = Timestamp(mlabMilli);
      cal.setTime(date);
      mtime(i)=datenum(cal.get(cal.YEAR),cal.get(cal.MONTH)+1,cal.get(cal.DAY_OF_MONTH),cal.get(cal.HOUR_OF_DAY),cal.get(cal.MINUTE),cal.get(cal.SECOND)+date.getNanos*1e-9);
    end
      
   
     
    