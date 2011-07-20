package
ovrkm{

	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;

	import mx.core.IUIComponent;

	public class BaseComponent extends MovieClip
	{
		public function BaseComponent()
		{
			stop();
		}

		public function getOutTimeline():TimelineMax
		{
			var timeline:TimelineMax = new TimelineMax({useFrames:true});
			timeline.append(TweenMax.fromTo(this, totalFrames, {ease:Linear.easeNone, frame:totalFrames, useFrames:true}, {ease:Linear.easeNone, frame:1, useFrames:true}));

			return timeline;
		}

		public function getInTimeline():TimelineMax
		{
			var timeline:TimelineMax = new TimelineMax({useFrames:true});
			timeline.append(TweenMax.fromTo(this, totalFrames, {ease:Linear.easeNone, frame:1, useFrames:true}, {ease:Linear.easeNone, frame:totalFrames, useFrames:true}));

			return timeline;
		}
	}
}