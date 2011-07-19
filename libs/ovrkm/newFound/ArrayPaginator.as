package ovrkm.newFound
{

	/**
	 *
	 * @author Anggie Bratadinata
	 */
	public class ArrayPaginator
	{
		private var _target:Array;
		private var _pageSize:int = 0;
		private var _totalPage:int = 0;
		
		private var _pageIndex:int = 0;
		private var _currentPage:Array;
		private var _targetLength:int;
		private var _pagedArray:Array;
		
		public function ArrayPaginator()
		{
			
		}
		
		/**
		 * Build a paginated array using a copy of the target array and return the first page.
		 * Later modifications to the target array will not be reflected unless this function is revoked.
		 *
		 * @param   target              The array to be paginated
		 * @param   pageSize            The number of items in each page
		 * @param   forceFullContent    Force all pages to contain equal number of items
		 * @param   pageFiller          Object to fill a page that has less number of items than the intended page size. Ignored if forceFullContent is false.
		 * @return
		 */
		
		public function paginate(target:Array, pageSize:int = 1, forceFullContent:Boolean = false, pageFiller:* = null):Array
		{
			if (pageSize < 1) {
				throw new ArgumentError("pageSize can't be less than 1");
				return null;
			}
			
			_target = target.concat();
			
			_targetLength = _target.length;
			
			_pageSize = pageSize;
			
			
			_totalPage = Math.ceil(_targetLength / _pageSize);
			
			
			if (forceFullContent)
			{
				var fillCount:int = (_totalPage * _pageSize) - _targetLength;
				
				if (fillCount > 0)
				{
					for (var j:int = 0; j < fillCount; j++)
					{
						_target.push(pageFiller);
					}
					
					_targetLength = _target.length;
				}
			}
			
			_pagedArray = [];
			
			for (var i:int = 0; i < _targetLength; i = i + _pageSize )
			{
				var sub:Array = _target.slice(i, i + _pageSize);
				_pagedArray.push(sub);
			}
			
			return firstPage;
		}
		
		/**
		 * Go to a page and get its content.
		 *
		 * @param   pageNum     Page number from 1 to total page.
		 * @return  Array Page content
		 */
		
		public function getPage(pageNum:int):Array
		{
			var idx:int = pageNum - 1;
			var a:Array = _pagedArray[idx];
			
			if (a != null)
			{
				_pageIndex = idx;
				_currentPage = a;
			}
			
			return a;
		}
		
		/**
		 * Go to the next page and get its content.
		 * @return Array
		 */
		
		public function pageUp():Array
		{
			if (currentPageNum == _totalPage)
			{
				return currentPage;
			}
			
			return getPage(currentPageNum + 1);
		};
		
		/**
		 * Go to the previous page and get its content.
		 * @return Array
		 */
		public function pageDown():Array
		{
			if (currentPageNum == 1)
			{
				return currentPage;
			}
			
			return getPage(currentPageNum - 1);
		};
		
		/**
		 * Get the content of the last page without moving the page pointer.
		 * @return Array
		 */
		
		public function peekLast():Array
		{
			return peekPage(_totalPage);
		}
		
		/**
		 * Get the content of the first page without moving the page pointer.
		 * @return Array
		 */
		
		public function peekFirst():Array
		{
			return peekPage(1);
		}
		
		/**
		 * Get the content of the next page without moving the page pointer.
		 * @return Array
		 */
		
		public function peekUp():Array
		{
			return peekPage(currentPageNum + 1);
		}
		
		/**
		 * Get the content of the previous page without moving the page pointer.
		 * @return Array
		 */
		
		public function peekDown():Array
		{
			return peekPage(currentPageNum - 1);
		}
		
		/**
		 * Get the content of a page without moving the page pointer.
		 * @param   pageNum  Page number from 1 to total page
		 * @return Array
		 */
		
		public function peekPage(pageNum:int):Array
		{
			var p:Array = _pagedArray[pageNum - 1];
			return p;
		}
		
		/**
		 * Get all pages.
		 * @return Array
		 */
		public function get pages():Array
		{
			return _pagedArray;
		}
		
		/**
		 * Go to the last page and get the content
		 * @return Array The page content
		 */
		
		public function get lastPage():Array
		{
			return getPage(_totalPage);
		};
		
		/**
		 * Go to the first page and get the content
		 * @return Array The page content
		 */
		
		public function get firstPage():Array
		{
			return getPage(1);
		};
		
		/**
		 * Get the current page number
		 */
		
		public function get currentPageNum():int
		{
			return _pageIndex + 1;
		}
		
		/**
		 * Get the total number of pages.
		 */
		public function get totalPage():int
		{
			return _totalPage;
		}
		
		/**
		 * Get the content of the current page.
		 * @return Array
		 */
		
		public function get currentPage():Array
		{
			return _currentPage;
		}
		
		/**
		 * True if the current page is the last page
		 */
		
		public function get isLast():Boolean
		{
			return (currentPageNum == _totalPage);
		}
		
		/**
		 * True if the current page is the first page
		 */
		
		public function get isFirst():Boolean
		{
			return (currentPageNum == 1);
		}
	}
	
}