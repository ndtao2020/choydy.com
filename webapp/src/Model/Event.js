export default class Event {
  constructor(event = {}) {
    this.id = typeof event.id === 'string' ? event.id : this.uuidv4()
    this.calendarId = typeof event.calendarId === 'string' ? event.calendarId : '1'
    this.title = typeof event.title === 'string' ? event.title : ''
    this.body = typeof event.body === 'string' ? event.body : ''
    this.isAllday = typeof event.isAllday === 'boolean' ? event.isAllday : false
    this.start = typeof event.start === 'object' ? new Date(event.start._date).toISOString() : event.start
    this.end = typeof event.end === 'object' ? new Date(event.end._date).toISOString() : event.end
    this.category = typeof event.category === 'string' ? event.category : 'time'
    this.dueDateClass = typeof event.dueDateClass === 'string' ? event.dueDateClass : ''
    this.color = this.eventColor(event.calendarId).color
    this.bgColor = this.eventColor(event.calendarId).bgColor
    this.dragBgColor = this.eventColor(event.calendarId).dragBgColor
    this.borderColor = this.eventColor(event.calendarId).borderColor
    this.customStyle = typeof event.customStyle === 'string' ? event.customStyle : ''
    this.isFocused = typeof event.isFocused === 'boolean' ? event.isFocused : false
    this.isPending = typeof event.isPending === 'boolean' ? event.isPending : false
    this.isVisible = typeof event.isVisible === 'boolean' ? event.isVisible : true
    this.isReadOnly = typeof event.isReadOnly === 'boolean' ? event.isReadOnly : false
    this.goingDuration = typeof event.goingDuration === 'string' ? event.goingDuration : ''
    this.comingDuration = typeof event.comingDuration === 'string' ? event.comingDuration : ''
    this.recurrenceRule = typeof event.recurrenceRule === 'string' ? event.recurrenceRule : ''
    this.state = typeof event.state === 'string' ? event.state : 'Busy'
    this.raw =
      typeof event.raw === 'object'
        ? {
            memo: 'Sano zauhi buhbol igjodok ri figraipo akicaho ogramoz huwcic guisuar azpusofi fecje jeni rug.',
            hasToOrCc: false,
            hasRecurrenceRule: false,
            location: null,
            class: 'public',
            creator: {
              name: 'Albert McKinney',
              avatar: '//www.gravatar.com/avatar/93c7ab8252e7d7100ce7835b0fbd3937',
              company: 'Rohm & Haas Co.',
              email: 'koonesuc@epigujto.kz',
              phone: '(622) 497-8105'
            }
          }
        : {}
    this.isPrivate = typeof event.isPrivate === 'boolean' ? event.isPrivate : false
    this.location = typeof event.location === 'string' ? event.location : '1'
    this.attendees = Array.isArray(event.attendees) ? event.attendees : []
  }

  uuidv4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      let r = (Math.random() * 16) | 0
      let v = c === 'x' ? r : (r & 0x3) | 0x8
      return v.toString(16)
    })
  }
  eventColor(categoryID) {
    let pal = {}
    switch (categoryID) {
      case '1':
        pal = {
          color: '#ffffff',
          bgColor: '#9e5fff',
          dragBgColor: '#9e5fff',
          borderColor: '#9e5fff'
        }
        break
      case '2':
        pal = {
          color: '#ffffff',
          bgColor: '#00a9ff',
          dragBgColor: '#00a9ff',
          borderColor: '#00a9ff'
        }
        break
      case '3':
        pal = {
          color: '#ffffff',
          bgColor: '#ff5583',
          dragBgColor: '#ff5583',
          borderColor: '#ff5583'
        }
        break
      case '4':
        pal = {
          color: '#ffffff',
          bgColor: '#03bd9e',
          dragBgColor: '#03bd9e',
          borderColor: '#03bd9e'
        }
        break
      case '5':
        pal = {
          color: '#ffffff',
          bgColor: '#bbdc00',
          dragBgColor: '#bbdc00',
          borderColor: '#bbdc00'
        }
        break
      case '6':
        pal = {
          color: '#ffffff',
          bgColor: '#9d9d9d',
          dragBgColor: '#9d9d9d',
          borderColor: '#9d9d9d'
        }
        break
      case '7':
        pal = {
          color: '#ffffff',
          bgColor: '#ffbb3b',
          dragBgColor: '#ffbb3b',
          borderColor: '#ffbb3b'
        }
        break
      case '8':
        pal = {
          color: '#ffffff',
          bgColor: '#ff4040',
          dragBgColor: '#ff4040',
          borderColor: '#ff4040'
        }
        break
    }
    return pal
  }
}
