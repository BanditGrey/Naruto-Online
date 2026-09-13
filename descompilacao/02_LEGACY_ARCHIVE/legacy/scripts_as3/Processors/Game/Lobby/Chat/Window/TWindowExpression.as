package Processors.Game.Lobby.Chat.Window
{
   import Components.Standard.*;
   import Foundation.Common.*;
   import Foundation.Display.TZoom9Grid;
   import Foundation.Fonts.*;
   import Foundation.Resources.Textures.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Resources.Constants.*;
   import Resources.Fonts.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.*;
   
   public class TWindowExpression extends TUIComponent
   {
      
      protected static const CAPACITY_Expression:uint = CONST_CHAT.CAPACITY_Expression;
      
      protected static const SIZE_CellExpressionWidth:int = 14;
      
      protected static const SIZE_CellExpressionHeight:int = 14;
      
      protected static const SIZE_CellCountX:int = 6;
      
      protected static const SIZE_CellCountY:int = 1;
      
      protected static const SIZE_Padding:uint = 5;
      
      protected static const SIZE_MarginLeft:uint = 5;
      
      protected static const SIZE_MarginTop:uint = 5;
      
      protected static const SIZE_MarginRight:uint = 5;
      
      protected static const SIZE_MarginBottom:uint = 5;
      
      protected var FZoom9Grid:TZoom9Grid;
      
      protected var FAnimationSubstrate:BitmapData;
      
      protected var FSubstrate:Sprite;
      
      protected var FOvarlaySubstrate:Bitmap;
      
      protected var FBounds:TBounds;
      
      protected var FImagesExpression:Vector.<TUIImage>;
      
      protected var FCoordinatePivot:TCoordinate;
      
      protected var FInitialization:Boolean;
      
      protected var FSequences:Vector.<TAnimationSequence>;
      
      protected var FOnIconClick:Function;
      
      public function TWindowExpression(param1:TUIComponent)
      {
         super(param1);
         this.FBounds = new TBounds();
         this.FBounds.Width = SIZE_MarginLeft + SIZE_CellCountX * SIZE_CellExpressionWidth + SIZE_MarginRight + (CAPACITY_Expression - 1) * SIZE_Padding;
         this.FBounds.Height = SIZE_MarginTop + SIZE_CellCountY * SIZE_CellExpressionHeight + SIZE_MarginBottom;
         this.ConstructSubstrate();
         this.ConstructButtonsExpression();
         this.ConstructSequences();
         this.FCoordinatePivot = new TCoordinate();
         this.Visible = false;
      }
      
      protected function ConstructSubstrate() : void
      {
         this.FSubstrate = new Sprite();
         addChild(this.FSubstrate);
         this.FOvarlaySubstrate = new Bitmap();
         this.FSubstrate.addChild(this.FOvarlaySubstrate);
      }
      
      protected function ConstructButtonsExpression() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIImage = null;
         this.FImagesExpression = new Vector.<TUIImage>(CAPACITY_Expression);
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_Expression)
         {
            _loc1_ = _loc3_ * SIZE_CellExpressionWidth + SIZE_Padding;
            _loc2_ = 0;
            _loc4_ = new TUIImage(this);
            _loc4_.x = _loc1_ + SIZE_Padding * _loc3_;
            _loc4_.y = _loc2_ + SIZE_Padding;
            _loc4_.buttonMode = true;
            _loc4_.Tag = _loc3_;
            _loc4_.addEventListener(MouseEvent.CLICK,this.IconOnClick,false,0,true);
            this.FImagesExpression[_loc3_] = _loc4_;
            _loc3_++;
         }
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         this.FAnimationSubstrate = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_COMMON.RESOURCE_ClassName_MC_HitTexture);
         this.FZoom9Grid = new TZoom9Grid(this.FAnimationSubstrate.clone());
         this.FZoom9Grid.GridRect = new Rectangle(22,22,12,12);
         this.FZoom9Grid.Width = this.FBounds.Width;
         this.FZoom9Grid.Height = this.FBounds.Height;
         if(this.FOvarlaySubstrate.bitmapData != this.FZoom9Grid.ImageData)
         {
            if(this.FOvarlaySubstrate.bitmapData != null)
            {
               this.FOvarlaySubstrate.bitmapData.dispose();
            }
            this.FOvarlaySubstrate.bitmapData = this.FZoom9Grid.ImageData;
         }
      }
      
      protected function ConstructSequences() : void
      {
         this.FSequences = new Vector.<TAnimationSequence>(CAPACITY_Expression);
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIImage = null;
         _loc2_ = int(CAPACITY_Expression);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FImagesExpression[_loc1_];
            _loc3_.Sequence = this.FSequences[_loc1_];
            _loc1_++;
         }
         this.FInitialization = true;
      }
      
      protected function IconOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TUIImage = null;
         _loc2_ = param1.currentTarget as TUIImage;
         if(this.FOnIconClick != null)
         {
            this.FOnIconClick(this,_loc2_.Tag);
         }
      }
      
      public function get Count() : int
      {
         return this.FSequences.length;
      }
      
      public function GetSequenceByIndex(param1:int) : TAnimationSequence
      {
         return this.FSequences[param1];
      }
      
      public function SetSequenceByIndex(param1:int, param2:TAnimationSequence) : void
      {
         this.FSequences[param1] = param2;
      }
      
      public function get OnImageClick() : Function
      {
         return this.FOnIconClick;
      }
      
      public function set OnImageClick(param1:Function) : void
      {
         this.FOnIconClick = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.ResourcesPerform_UIDispatch();
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
   }
}

