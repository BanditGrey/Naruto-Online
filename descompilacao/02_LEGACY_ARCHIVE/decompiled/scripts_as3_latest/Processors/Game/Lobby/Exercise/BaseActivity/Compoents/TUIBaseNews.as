package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TUIBaseNews extends TUIComponent
   {
      
      protected static const QUALITYCOLOR_None:uint = 16777215;
      
      protected static const QUALITYCOLOR_White:uint = 16777215;
      
      protected static const QUALITYCOLOR_Green:uint = 6881026;
      
      protected static const QUALITYCOLOR_Blue:uint = 38655;
      
      protected static const QUALITYCOLOR_Purple:uint = 10027215;
      
      protected static const QUALITYCOLOR_Yellow:uint = 16776960;
      
      protected static const QUALITYCOLOR_Red:uint = 16646144;
      
      protected static const QUALITYCOLOR_Orange:uint = 16711808;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      protected var FNameSprite:Sprite;
      
      protected var FItemSprite:Sprite;
      
      protected var FNewsData:TLotteryNews;
      
      protected var FIndex:int;
      
      protected var FText:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_NewsType:TextField;
      
      protected var FTF_ItemName:TextField;
      
      protected var FOVER_FORMAT:TextFormat;
      
      protected var FOUT_FORMAT:TextFormat;
      
      protected var FFORMAT_NAME:TextFormat;
      
      protected var FFORMAT_ITEM:TextFormat;
      
      protected var FFORMAT_NORMAL:TextFormat;
      
      protected var FOnItemOver:Function;
      
      protected var FOnItemOut:Function;
      
      protected var FOnNameUp:Function;
      
      protected var FStubReferences:TStubReferences;
      
      public function TUIBaseNews(param1:TUIComponent)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.Initialization();
      }
      
      protected function Initialization() : void
      {
         if(this.FFORMAT_NAME == null)
         {
            this.FFORMAT_NAME = new TextFormat();
            this.FFORMAT_NAME.underline = true;
            this.FFORMAT_NAME.color = 16777215;
         }
         if(this.FFORMAT_ITEM == null)
         {
            this.FFORMAT_ITEM = new TextFormat();
            this.FFORMAT_ITEM.underline = true;
         }
         if(this.FFORMAT_NORMAL == null)
         {
            this.FFORMAT_NORMAL = new TextFormat();
            this.FFORMAT_NORMAL.color = 16737792;
         }
         this.FNameSprite = new Sprite();
         this.FNameSprite.buttonMode = true;
         this.FNameSprite.mouseChildren = false;
         addChild(this.FNameSprite);
         this.FTF_Time = new TextField();
         this.FTF_Time.mouseEnabled = false;
         this.FTF_Time.autoSize = TextFieldAutoSize.LEFT;
         this.FTF_Time.filters = [new GlowFilter(2818048,1,2,2,5)];
         this.FNameSprite.addChild(this.FTF_Time);
         this.FTF_Name = new TextField();
         this.FTF_Name.mouseEnabled = false;
         this.FTF_Name.autoSize = TextFieldAutoSize.LEFT;
         this.FTF_Name.filters = [new GlowFilter(2818048,1,2,2,5)];
         this.FNameSprite.addChild(this.FTF_Name);
         this.FTF_NewsType = new TextField();
         this.FTF_NewsType.mouseEnabled = false;
         this.FTF_NewsType.autoSize = TextFieldAutoSize.LEFT;
         this.FTF_NewsType.filters = [new GlowFilter(2818048,1,2,2,5)];
         addChild(this.FTF_NewsType);
         this.FItemSprite = new Sprite();
         this.FItemSprite.buttonMode = true;
         this.FItemSprite.mouseChildren = false;
         addChild(this.FItemSprite);
         this.FTF_ItemName = new TextField();
         this.FTF_ItemName.mouseEnabled = false;
         this.FTF_ItemName.autoSize = TextFieldAutoSize.LEFT;
         this.FTF_ItemName.filters = [new GlowFilter(2818048,1,2,2,5)];
         this.FItemSprite.addChild(this.FTF_ItemName);
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         this.FNameSprite.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnNameUp,false,0,true);
         this.FItemSprite.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnItemMove,false,0,true);
         this.FItemSprite.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnItemOut,false,0,true);
      }
      
      protected function ProcessorOnNameUp(param1:MouseEvent) : void
      {
         if(this.FOnNameUp != null)
         {
            this.FOnNameUp(this.FNewsData.Identifier0,this.FNewsData.Identifier1);
         }
      }
      
      protected function ProcessorOnItemMove(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FNewsData.Inventories.GetInventoryByIndex(0);
         if(this.FOnItemOver != null)
         {
            this.FOnItemOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnItemOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         _loc2_ = this.FNewsData.Inventories.GetInventoryByIndex(0);
         if(this.FOnItemOut != null)
         {
            this.FOnItemOut(this,_loc2_);
         }
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get NewsData() : TLotteryNews
      {
         return this.FNewsData;
      }
      
      public function set NewsData(param1:TLotteryNews) : void
      {
         this.FNewsData = param1;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
      }
      
      public function get OnItemOver() : Function
      {
         return this.FOnItemOver;
      }
      
      public function set OnItemOver(param1:Function) : void
      {
         this.FOnItemOver = param1;
      }
      
      public function get OnItemOut() : Function
      {
         return this.FOnItemOut;
      }
      
      public function set OnItemOut(param1:Function) : void
      {
         this.FOnItemOut = param1;
      }
      
      public function get OnNameUp() : Function
      {
         return this.FOnNameUp;
      }
      
      public function set OnNameUp(param1:Function) : void
      {
         this.FOnNameUp = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:TSystemLanguage = null;
         _loc2_ = this.FNewsData.Inventories.GetInventoryByIndex(0);
         if(_loc2_ == null)
         {
            return;
         }
         if(this.FNewsData.GetTime > 0)
         {
            this.FTF_Time.text = TUtilityDate.FormatDateChineseNew(new Date(this.FNewsData.GetTime * 1000));
            this.FTF_Time.setTextFormat(this.FFORMAT_NORMAL);
         }
         if(this.FNewsData.PlayerNick)
         {
            this.FTF_Name.text = this.FNewsData.PlayerNick;
            this.FTF_Name.setTextFormat(this.FFORMAT_NAME);
         }
         if(this.FNewsData.SoureID == 0)
         {
            this.FTF_NewsType.htmlText = STRING_BASEACTIVITY.FORMAT_News_String;
         }
         else
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.FNewsData.SoureID) as TSystemLanguage;
            this.FTF_NewsType.htmlText = _loc4_.Desc;
            this.FTF_NewsType.setTextFormat(this.FFORMAT_NORMAL);
         }
         this.FTF_Name.x = this.FTF_Time.width;
         this.FTF_NewsType.x = this.FNameSprite.x + this.FTF_Name.width + this.FTF_Time.width;
         this.FTF_ItemName.text = _loc2_.Name + " x " + _loc2_.Quantity;
         this.FFORMAT_ITEM.color = QUALITYCOLOR_INDEX[_loc2_.Quality];
         this.FTF_ItemName.setTextFormat(this.FFORMAT_ITEM);
         this.FTF_ItemName.x = this.FTF_NewsType.x + this.FTF_NewsType.width + 10;
      }
      
      public function Release() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

