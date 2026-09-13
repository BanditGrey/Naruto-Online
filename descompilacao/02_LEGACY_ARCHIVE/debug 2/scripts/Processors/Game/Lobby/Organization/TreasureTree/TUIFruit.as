package Processors.Game.Lobby.Organization.TreasureTree
{
   import Foundation.UI.TUIComponent;
   import Logics.Organization.TreasureTree.TUserFruitInfo;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIFruit extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_FruitName:TextField;
      
      protected var FMC_HasMature:Sprite;
      
      protected var FMC_Fruit:MovieClip;
      
      protected var FFruitOnOver:Function;
      
      protected var FFruitOnOut:Function;
      
      protected var FFruitOnClick:Function;
      
      public function TUIFruit(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_FruitName = FResource["TF_FruitName"];
         this.FMC_HasMature = FResource["MC_HasMature"];
         if(FTag > 3)
         {
            FResource.gotoAndStop(2);
         }
         this.FMC_Fruit = FResource["MC_Fruit"];
         this.FMC_Fruit.gotoAndStop(1);
         this.FMC_Fruit.buttonMode = true;
         this.FMC_HasMature.visible = false;
         this.FMC_HasMature.mouseEnabled = false;
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
         this.FMC_Fruit.addEventListener(MouseEvent.MOUSE_OVER,this.ResourceOnOver,false,0,true);
         this.FMC_Fruit.addEventListener(MouseEvent.MOUSE_OUT,this.ResourceOnOut,false,0,true);
         this.FMC_Fruit.addEventListener(MouseEvent.CLICK,this.ResourceOnCLICK,false,0,true);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TUserFruitInfo = null;
         var _loc2_:Boolean = false;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc1_ = FContext as TUserFruitInfo;
         this.FTF_FruitName.text = _loc1_.FruitName;
         _loc2_ = _loc1_.FruitMatureTime == 0;
         this.FMC_HasMature.visible = _loc2_;
         if(_loc2_)
         {
            this.FMC_Fruit.play();
         }
         else
         {
            this.FMC_Fruit.gotoAndStop(1);
         }
      }
      
      protected function ResourceOnOver(param1:MouseEvent) : void
      {
         if(this.FFruitOnOver != null)
         {
            this.FFruitOnOver(this,FContext);
         }
      }
      
      protected function ResourceOnOut(param1:MouseEvent) : void
      {
         if(this.FFruitOnOut != null)
         {
            this.FFruitOnOut(this);
         }
      }
      
      protected function ResourceOnCLICK(param1:MouseEvent) : void
      {
         if(this.FFruitOnClick != null)
         {
            this.FFruitOnClick(this,FContext);
         }
      }
      
      public function set FruitOnOver(param1:Function) : void
      {
         this.FFruitOnOver = param1;
      }
      
      public function set FruitOnOut(param1:Function) : void
      {
         this.FFruitOnOut = param1;
      }
      
      public function set FruitOnClick(param1:Function) : void
      {
         this.FFruitOnClick = param1;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FMC_HasMature.visible = false;
         this.FMC_Fruit.gotoAndStop(1);
      }
   }
}

