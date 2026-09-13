package Processors.Game.Lobby.Exercise.Dice.Compoents
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Dice.TDice;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_DICE;
   import Resources.Strings.STRING_DICE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIBar extends TUIComponent
   {
      
      protected static const BOX_COUNT:int = 10;
      
      protected static const INIT_ARROW_X:int = 47;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBTN_Get:MovieClip;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FMC_Exp:MovieClip;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FMC_Arrow:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FDice:TDice;
      
      protected var FBarIndex:int;
      
      protected var FMaxBarNum:int;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FOnGetReward:Function;
      
      protected var FOnItemOver:Function;
      
      protected var FOnItemOut:Function;
      
      public function TUIBar(param1:TUIComponent)
      {
         super(param1);
         this.FDice = SLogicsCore.Dice;
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent.Parent);
         this.FOverlayerBox.Visible = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FBTN_Get = this.FMC_Scene.BTN_Get;
         TGameUtil.setButtonMode(this.FBTN_Get,true);
         this.FBTN_Get.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnGetReward);
         this.FMC_Bar = this.FMC_Scene[CONST_DICE.RESOURCE_LINK_MC_Bar];
         this.FMC_Mask = this.FMC_Bar[CONST_DICE.RESOURCE_LINK_MC_Mask];
         this.FMC_Exp = this.FMC_Bar.MC_Exp;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FMC_Arrow = this.FMC_Scene.MC_Arrow;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
         this.Resources_UIDispatchBox();
      }
      
      protected function Resources_UIDispatchBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FMC_Scene["MC_Box" + _loc1_];
            this.FBoxList[_loc1_] = _loc3_;
            _loc3_.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnItemMove);
            _loc3_.MC_Box.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnItemOut);
            _loc1_++;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FDice.BoxList.length);
         this.FMaxBarNum = this.FDice.BoxList[_loc2_ - 1].NeedWinCount;
         if(TDice.WIN_COUNT_VEC.indexOf(this.FDice.WinCount) != -1 && this.FDice.WinCount != 0)
         {
            _loc1_ = this.FBarMaxWidth;
         }
         else
         {
            _loc1_ = Number(this.FDice.WinCount) % this.FMaxBarNum / this.FMaxBarNum * this.FBarMaxWidth;
         }
         this.FMC_Mask.width = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Arrow.x = INIT_ARROW_X + this.FMC_Mask.width;
         this.FMC_Arrow.TF_Count.text = TUtilityString.Format(STRING_DICE.FORMAT_WIN_COUNTS,this.FDice.WinCount);
         this.FMC_Exp.gotoAndStop(this.FBarIndex + 1);
         this.FMC_Scene.MC_Effect.gotoAndPlay(1);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            _loc4_ = _loc3_.MC_Box;
            _loc5_ = _loc3_.TF_Count;
            _loc6_ = this.FBarIndex * BOX_COUNT + _loc1_;
            if(_loc6_ < this.FDice.BoxList.length)
            {
               _loc3_.visible = true;
               _loc5_.text = TUtilityString.Format(STRING_DICE.FORMAT_WIN_COUNT,this.FDice.BoxList[_loc6_].NeedWinCount);
               _loc7_ = this.FDice.BoxList[_loc6_].Color;
               switch(this.FDice.BoxList[_loc6_].Status)
               {
                  case -1:
                     _loc4_.gotoAndStop(1);
                     _loc4_.notOpen.gotoAndStop(_loc7_);
                     _loc4_.notOpen.filters = [TGameUtil.GaryColorFilters];
                     break;
                  case 0:
                     _loc4_.gotoAndStop(2);
                     _loc4_.canGet.MC_OpenBox.gotoAndStop(_loc7_);
                     break;
                  case 1:
                     _loc4_.gotoAndStop(3);
                     _loc4_.Got.gotoAndStop(_loc7_);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FDice.CheckAwardStatus())
         {
            TGameUtil.setButtonMode(this.FBTN_Get,true);
            this.FBTN_Get.up.play();
            this.FBTN_Get.filters = [];
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Get,false);
            this.FBTN_Get.disabled.stop();
            this.FBTN_Get.filters = [TGameUtil.GaryColorFilters];
         }
      }
      
      protected function ProcessorOnGetReward(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         TGameUtil.setButtonMode(this.FBTN_Get,false);
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward();
         }
      }
      
      protected function ProcessorOnItemMove(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FDice.BoxList.length);
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc3_ >= _loc4_)
         {
            return;
         }
         _loc2_ = this.FDice.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
         if(this.FOnItemOver != null)
         {
            this.FOnItemOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnItemOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = int(this.FDice.BoxList.length);
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(_loc3_ >= _loc4_)
         {
            return;
         }
         _loc2_ = this.FDice.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
         if(this.FOnItemOut != null)
         {
            this.FOnItemOut(this,_loc2_);
         }
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.visible)
         {
         }
      }
      
      public function UpdateUI() : void
      {
         this.FDice = SLogicsCore.Dice;
         this.FBarIndex = this.FDice.GetBarIndex();
         this.UpdateBar();
         this.UpdateBox();
         this.UpdateBtn();
      }
   }
}

