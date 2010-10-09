package org.finalbug.framework.events
{
	import flash.events.Event;

	public class AlertEvent extends Event
	{
		public function AlertEvent()
		{
			super(type, bubbles, cancelable);
		}
	}
}