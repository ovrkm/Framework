package
{

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;

	public class BaseComponent extends MovieClip
	{
		public var inTimeline:TimelineMax;
		public var outTimeline:TimelineMax;

		public function BaseComponent()
		{
			stop();

			inTimeline = new TimelineMax({useFrames:true});
			inTimeline.append(TweenMax.fromTo(this, totalFrames, {ease:Linear.easeNone, frame:1, useFrames:true}, {ease:Linear.easeNone, frame:totalFrames, useFrames:true}));
			inTimeline.pause();

			outTimeline = new TimelineMax({useFrames:true});
			outTimeline.append(TweenMax.fromTo(this, totalFrames, {ease:Linear.easeNone, frame:totalFrames, useFrames:true}, {ease:Linear.easeNone, frame:1, useFrames:true}));
			outTimeline.pause();
		}

		public function show(fromStart:Boolean=false):void
		{
			inTimeline.restart();
		}

		public function hide(fromStart:Boolean=false):void
		{
			outTimeline.restart();
		}
	}
}