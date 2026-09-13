package Processors.Game.Lobby.Married.Panel
{
   import Foundation.Display.TZoom9Grid;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TRingValue;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_OVERLAYEREQUIPMENT;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TUIRingTips extends Sprite
   {
      
      protected var FFilters:Array = null;
      
      protected var FRectangle:Rectangle = null;
      
      protected var FZoom9Grid:TZoom9Grid = null;
      
      protected var FBackgroup:Bitmap = null;
      
      public function TUIRingTips(param1:TUIComponent)
      {
         super();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.visible = false;
         param1.addChild(this);
         this.FFilters = new Array();
         this.FFilters.push(new GlowFilter(0,1,3,3,10,1,false,false));
         this.FRectangle = new Rectangle();
         this.FBackgroup = new Bitmap();
         this.addChild(this.FBackgroup);
      }
      
      public function Show(param1:int, param2:Point = null) : void
      {
         this.visible = true;
         this.parent.setChildIndex(this,this.parent.numChildren - 1);
         if(param2)
         {
            this.x = param2.x;
            this.y = param2.y;
         }
         this.FRectangle.x = 10;
         this.FRectangle.y = 10;
         var _loc3_:Vector.<uint> = new Vector.<uint>();
         if(param1 == -1)
         {
            _loc3_.push(14211709);
            _loc3_.push(14211710);
            _loc3_.push(14211711);
         }
         else
         {
            _loc3_.push(param1);
         }
         var _loc4_:TInventories = new TInventories();
         var _loc5_:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc5_.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc4_,_loc3_);
         var _loc6_:int = _loc4_.Count;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            this.CreateItemTips(_loc4_.GetInventoryByIndex(_loc7_));
            _loc7_++;
         }
         if(this.FZoom9Grid == null)
         {
            this.FZoom9Grid = new TZoom9Grid(TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_COMMON.RESOURCE_ClassName_MC_HitTexture).clone());
            this.FZoom9Grid.GridRect = new Rectangle(22,22,12,12);
         }
         var _loc8_:Rectangle = this.MaxRectangle();
         this.FZoom9Grid.Width = _loc8_.width;
         this.FZoom9Grid.Height = _loc8_.height;
         this.FBackgroup.bitmapData = this.FZoom9Grid.ImageData;
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      private function CreateItemTips(param1:TInventory) : void
      {
         this.CreateItemText(param1.Name,15,CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality],true,10);
         var _loc2_:String = "";
         var _loc3_:TRingValue = THomelandModel.getRingVOByLevel(param1.IDTemplate,1);
         var _loc4_:Array = JSON.parse(_loc3_.Value).addOther;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ += TIllustratedModel.AttributeFormat(_loc4_[_loc5_].type,_loc4_[_loc5_].value) + "\n";
            _loc5_++;
         }
         var _loc6_:TextField = this.CreateItemText(STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributeCaption,13,16777215,false,5);
         var _loc7_:TextField = this.CreateItemText(_loc2_,13,16777215,false,5);
         _loc7_.x = _loc6_.x + _loc6_.textWidth + 10;
         _loc7_.y = _loc6_.y;
      }
      
      private function CreateItemText(param1:String, param2:int, param3:uint, param4:Boolean, param5:int) : TextField
      {
         var _loc6_:TextField = new TextField();
         _loc6_.defaultTextFormat = new TextFormat("宋体",param2,param3,param4);
         _loc6_.text = param1;
         _loc6_.textColor = param3;
         _loc6_.x = this.FRectangle.x;
         _loc6_.y = this.FRectangle.y;
         _loc6_.filters = this.FFilters;
         _loc6_.width = _loc6_.textWidth + 5;
         _loc6_.height = _loc6_.textHeight + 5;
         this.addChild(_loc6_);
         this.FRectangle.y = _loc6_.y + _loc6_.textHeight + param5;
         return _loc6_;
      }
      
      private function MaxRectangle() : Rectangle
      {
         var _loc5_:DisplayObject = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this.numChildren;
         var _loc4_:int = 1;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.getChildAt(_loc4_);
            _loc1_ = Math.max(_loc1_,_loc5_.x + _loc5_.width);
            _loc2_ = Math.max(_loc2_,_loc5_.y + _loc5_.height);
            _loc4_++;
         }
         return new Rectangle(0,0,_loc1_ + 10,_loc2_ + 10);
      }
   }
}

