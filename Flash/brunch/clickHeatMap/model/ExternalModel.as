package brunch.clickHeatMap.model {
  import flash.external.ExternalInterface;
  import flash.geom.Rectangle;
  import flash.net.URLVariables;
	/**
   * 保存外部参数和外部命令调用
   * @author Meathill
   * @version 0.1(2011-09-05)
   */
  public class ExternalModel {
    //=========================================================================
    // Class Constants
    //=========================================================================
    public static const CMD_SHOW_DETAIL:String = 'CountArea.showDetail';
    public static const CMS_REMOVE_DETAIL:String = 'CountArea.removeDetail';
    public static const PLACE_HOLDER:Vector.<String> = new <String>['r', 'u', 'd', 'b', 'ab', 'nocache', 'visitor'];
    //=========================================================================
    // Class Variables
    //=========================================================================
    private static var INSTANCE:ExternalModel;
    //=========================================================================
    // Class Public Methods
    //=========================================================================
    public static function getInstance(obj:Object = null):ExternalModel {
      if (INSTANCE == null) {
        INSTANCE = new ExternalModel(obj);
      }
      return INSTANCE;
    }
    //=========================================================================
    // Constructor
    //=========================================================================
    public function ExternalModel(obj:Object) {
      if (obj.hasOwnProperty('useHtmlDetail')) {
        useHtmlDetail = obj.useHtmlDetail;
      }
      
      _param = new URLVariables();
      _param.r = 'http://dealer.zol.com.cn/';
			_param.d = '110624';
			_param.nocache = 0;
			_param.visitor = 'new';
			for (var prop:String in obj) {
        if (PLACE_HOLDER.indexOf(prop) != -1) {
          _param[prop] = obj[prop];
        }
			}
    }
    //=========================================================================
    // Properties
    //========================================================================= 
		public var clientWidth:int;
		public var remote:String;
    public var useHtmlDetail:Boolean = true;
    public function get param():URLVariables {
      return new URLVariables(_param.toString());
    }
    //=========================================================================
    // Variables
    //=========================================================================
    private var _param:URLVariables;
    //=========================================================================
    // Public Methods
    //=========================================================================
    public function showDetail(id:int, arr:Array = null, rect:Rectangle = null, color:uint = 0xFFFFFF):void {
      if (ExternalInterface.available) {
        rect = rect || new Rectangle();
        ExternalInterface.call(CMD_SHOW_DETAIL, id, arr, rect.x, rect.y, rect.width, rect.height, color);
      }
    }
    public function removeDetail(id:int):void {
      if (ExternalInterface.available) {
        ExternalInterface.call(CMS_REMOVE_DETAIL, id);
      }
    }
    
  }
}