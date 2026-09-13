package Processors.Game.Lobby.Pet.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Resources.Constants.CONST_PET;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_PET;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUIEnergyBar extends TUIComponent
   {
      
      public var FMC:MovieClip;
      
      protected var FMC_MC:Sprite;
      
      protected var FMC_Word:MovieClip;
      
      protected var FMC_SoulExpBar:Sprite;
      
      protected var FMC_Barrier:Sprite;
      
      protected var FMC_Finish:Sprite;
      
      protected var FTF_SoulLevel:TextField;
      
      protected var FTF_SoulExp:TextField;
      
      protected var FTF_PlusValue:TextField;
      
      protected var FTF_NextPlusValue:TextField;
      
      public function TUIEnergyBar(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FMC_MC = this.FMC[CONST_PET.RESOURCE_Link_MC_MC] as Sprite;
         this.FMC_Word = this.FMC_MC[CONST_PET.RESOURCE_Link_MC_Word] as MovieClip;
         this.FMC_SoulExpBar = this.FMC_MC[CONST_PET.RESOURCE_Link_MC_SoulExpBar];
         this.FMC_Barrier = this.FMC_MC[CONST_PET.RESOURCE_Link_MC_Barrier];
         this.FMC_Finish = this.FMC_MC[CONST_PET.RESOURCE_Link_MC_Finish];
         this.FTF_SoulLevel = this.FMC_MC[CONST_PET.RESOURCE_Link_TF_SoulLevel];
         this.FTF_SoulExp = this.FMC_MC[CONST_PET.RESOURCE_Link_TF_SoulExp];
         this.FTF_PlusValue = this.FMC_MC[CONST_PET.RESOURCE_Link_TF_PlusValue];
         this.FTF_NextPlusValue = this.FMC_MC[CONST_PET.RESOURCE_Link_TF_NextPlusValue];
         this.FTF_SoulLevel.mouseEnabled = this.FTF_SoulExp.mouseEnabled = this.FTF_PlusValue.mouseEnabled = this.FTF_NextPlusValue.mouseEnabled = false;
         this.FTF_SoulExp.visible = true;
         this.FMC.gotoAndPlay(1);
      }
      
      public function set MCVisible(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC.filters = [];
         }
         else
         {
            this.FMC.filters = [TGameUtil.GaryColorFilters];
         }
      }
      
      public function set ExpVisible(param1:Boolean) : void
      {
         this.FTF_SoulExp.visible = param1;
      }
      
      public function set BarrierVisible(param1:Boolean) : void
      {
         this.FMC_Barrier.visible = param1;
      }
      
      public function set SetView(param1:Boolean) : void
      {
         this.FMC_Finish.visible = param1;
         this.FMC_Barrier.visible = param1;
         if(param1)
         {
            this.FMC_Word.gotoAndStop(1);
         }
         else
         {
            this.FMC_Word.gotoAndStop(2);
         }
      }
      
      public function set SetLevel(param1:uint) : void
      {
         this.FTF_SoulLevel.text = STRING_COMMON.FORMAT_Level + param1.toString();
      }
      
      public function set SetCurrentValue(param1:uint) : void
      {
         this.FTF_PlusValue.text = "+" + param1.toString();
      }
      
      public function set SetNextValue(param1:uint) : void
      {
         this.FTF_NextPlusValue.text = "+" + param1.toString();
      }
      
      public function SetNextValueView() : void
      {
         this.FTF_NextPlusValue.visible = false;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
      }
      
      public function UpDateExp(param1:uint, param2:uint) : void
      {
         var _loc3_:Number = NaN;
         this.FTF_SoulExp.text = TUtilityString.Format(STRING_PET.FORMAT_EXP,param1,param2);
         _loc3_ = param1 / param2;
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         this.FMC_SoulExpBar.scaleY = _loc3_;
      }
   }
}

