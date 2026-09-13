package Processors.Game.Lobby.Backpack
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_BACKPACK;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowLock extends TProcessorLobbyWindow
   {
      
      protected static const TYPE_NONE:int = 0;
      
      protected static const TYPE_SET:int = 1;
      
      protected static const TYPE_CANCEL:int = 2;
      
      protected static const TYPE_USE:int = 3;
      
      protected var FScene:MovieClip;
      
      protected var FType:uint;
      
      protected var FFirstInputInRule:Boolean;
      
      protected var FSecondInputInRule:Boolean;
      
      public function TProcessorWindowLock(param1:TUIComponent)
      {
         super(param1);
         this.InitScene();
      }
      
      protected function InitScene() : void
      {
         this.FType = TYPE_NONE;
         this.FFirstInputInRule = false;
         this.FSecondInputInRule = false;
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BACKPACK.RESOURCE_ClassName_MC_Lock) as MovieClip;
         addChild(this.FScene);
         TGameUtil.setButtonMode(this.FScene.btn_sure,true);
         this.FScene.btn_sure.addEventListener(MouseEvent.CLICK,this.OnSure);
         TGameUtil.setButtonMode(this.FScene.btn_cancel,true);
         this.FScene.btn_cancel.addEventListener(MouseEvent.CLICK,this.OnCancel);
         this.FScene.mc_setLock.tf_inputFirst.maxChars = 8;
         this.FScene.mc_setLock.tf_inputFirst.displayAsPassword = true;
         this.FScene.mc_setLock.tf_inputFirst.addEventListener(Event.CHANGE,this.OnSetLockFirstChg);
         this.FScene.mc_setLock.tf_inputSecond.maxChars = 8;
         this.FScene.mc_setLock.tf_inputSecond.displayAsPassword = true;
         this.FScene.mc_setLock.tf_inputSecond.addEventListener(Event.CHANGE,this.OnSetLockSecondChg);
         this.FScene.mc_cancelLock.tf_input.maxChars = 8;
         this.FScene.mc_cancelLock.tf_input.displayAsPassword = true;
         this.FScene.mc_cancelLock.tf_input.addEventListener(Event.CHANGE,this.OnCancelLockChg);
         this.FScene.mc_sellInputLock.tf_input.maxChars = 8;
         this.FScene.mc_sellInputLock.tf_input.displayAsPassword = true;
         this.FScene.mc_sellInputLock.tf_input.addEventListener(Event.CHANGE,this.OnSellLockChg);
      }
      
      protected function Updata() : void
      {
      }
      
      protected function CheckStringRule(param1:String) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(param1 == null || param1.length <= 0)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc2_);
            if(!(_loc3_ >= "a" && _loc3_ <= "z" || _loc3_ >= "0" && _loc3_ <= "9" || _loc3_ >= "A" && _loc3_ <= "Z"))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      protected function CheckSetLockSureBtn() : void
      {
         if(this.FFirstInputInRule && this.FSecondInputInRule)
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,false);
         }
      }
      
      protected function OnSure(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FType != TYPE_SET)
         {
            if(this.FType == TYPE_CANCEL)
            {
               _loc2_ = this.FScene.mc_cancelLock.tf_input.text;
               if(!this.CheckStringRule(_loc2_))
               {
                  if(FOnEffectText != null)
                  {
                     FOnEffectText("异常字符!");
                  }
               }
            }
            else if(this.FType == TYPE_CANCEL)
            {
               _loc2_ = this.FScene.mc_sellInputLock.tf_input.text;
               if(!this.CheckStringRule(_loc2_))
               {
                  if(FOnEffectText != null)
                  {
                     FOnEffectText("异常字符!");
                  }
               }
            }
         }
      }
      
      protected function OnCancel(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      protected function OnSetLockFirstChg(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FScene.mc_setLock.tf_inputFirst.text;
         this.FScene.mc_setLock.mc_firstStatus.visible = Boolean(_loc2_.length > 0);
         if(this.CheckStringRule(_loc2_))
         {
            this.FFirstInputInRule = true;
            this.FScene.mc_setLock.mc_firstStatus.gotoAndStop(1);
         }
         else
         {
            this.FFirstInputInRule = false;
            this.FScene.mc_setLock.mc_firstStatus.gotoAndStop(2);
         }
         this.OnSetLockSecondChg(null);
         this.CheckSetLockSureBtn();
      }
      
      protected function OnSetLockSecondChg(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc2_ = this.FScene.mc_setLock.tf_inputFirst.text;
         _loc3_ = this.FScene.mc_setLock.tf_inputSecond.text;
         this.FScene.mc_setLock.mc_secondStatus.visible = Boolean(_loc3_.length > 0);
         if(_loc2_ == _loc3_ && this.FFirstInputInRule)
         {
            this.FSecondInputInRule = true;
            this.FScene.mc_setLock.mc_secondStatus.gotoAndStop(1);
         }
         else
         {
            this.FSecondInputInRule = false;
            this.FScene.mc_setLock.mc_secondStatus.gotoAndStop(2);
         }
         this.CheckSetLockSureBtn();
      }
      
      protected function OnCancelLockChg(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FScene.mc_cancelLock.tf_input.text;
         if(_loc2_.length > 0)
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,false);
         }
      }
      
      protected function OnSellLockChg(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FScene.mc_sellInputLock.tf_input.text;
         if(_loc2_.length > 0)
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FScene.btn_sure,false);
         }
      }
      
      public function set SureBtnName(param1:String) : void
      {
         this.FScene.btn_sure.tf_btnName.text = param1;
      }
      
      public function set LockDesc(param1:String) : void
      {
         this.FScene.tf_desc.text = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(param1)
         {
            this.Updata();
         }
      }
      
      protected function UpdataUI() : void
      {
         this.FScene.mc_setLock.visible = Boolean(this.FType == TYPE_SET);
         this.FScene.mc_cancelLock.visible = Boolean(this.FType == TYPE_CANCEL);
         this.FScene.mc_sellInputLock.visible = Boolean(this.FType == TYPE_USE);
         TGameUtil.setButtonMode(this.FScene.btn_sure,false);
      }
      
      public function StartSetLock() : void
      {
         this.FType = TYPE_SET;
         this.UpdataUI();
         this.FScene.mc_setLock.tf_inputFirst.text = "";
         this.FScene.mc_setLock.tf_inputSecond.text = "";
         this.FScene.mc_setLock.mc_firstStatus.visible = false;
         this.FScene.mc_setLock.mc_secondStatus.visible = false;
         this.SureBtnName = STRING_COMMON.STRING_Lock_Add;
      }
      
      public function CancelLock() : void
      {
         this.FType = TYPE_CANCEL;
         this.UpdataUI();
         this.FScene.mc_cancelLock.tf_input.text = "";
         this.SureBtnName = STRING_COMMON.STRING_Lock_Dec;
      }
      
      public function UseLock() : void
      {
         this.FType = TYPE_USE;
         this.UpdataUI();
         this.FScene.mc_sellInputLock.tf_input.text = "";
         this.SureBtnName = STRING_COMMON.STRING_Lock_Sure;
      }
   }
}

