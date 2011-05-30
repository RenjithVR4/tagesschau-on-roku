Function newLiveStream(source As Object) As Object
    stream = CreateObject("roAssociativeArray")
    stream.title = source.title
    stream.url = source.mediadata[0].m3u8_a_high
    stream.startTime = source.start
    stream.endTime = source.end
    stream.format = "hls"
    stream.bitrate = 0
    images = mergeAArrays(source.images[0].variants)
    stream.image = images.mittel16x9
    stream.AsContent = streamAsContent
    return stream
End Function

Function streamAsContent() 
    content = CreateObject("roAssociativeArray")
    content.ContentType = "episode"
    content.Title = m.title + " Live Stream"
    content.ShortDescriptionLine1 = content.Title
    if(m.startTime <> invalid and m.endTime <> invalid)
        content.ShortDescriptionLine2 = m.startTime + " - " + m.endTime + " Uhr" 
    end if
    content.Rating = "NR"
    content.SDPosterUrl = m.image
    content.HDPosterUrl = m.image
    content.hasFetchedDetails = true
    content.StreamFormat = m.format
    streams = CreateObject("roList")
    stream = CreateObject("roAssociativeArray")
    stream.url = m.url
    stream.bitrate = m.bitrate
    stream.quality = false
    streams.addTail(stream)
    content.Streams = streams
    return content
End Function