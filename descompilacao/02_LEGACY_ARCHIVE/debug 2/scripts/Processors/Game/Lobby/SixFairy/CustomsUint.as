package Processors.Game.Lobby.SixFairy
{
   import Foundation.Utilities.TGameUtil;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class CustomsUint
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FBtn_enter:MovieClip = null;
      
      protected var FTF_Enter:TextField = null;
      
      protected var FMC_Icon:MovieClip = null;
      
      protected var FBitmapHead:Bitmap = null;
      
      protected var FResoureId:int = 0;
      
      protected var FThisClassBelongWho:int;
      
      protected var FCurIndex:int;
      
      protected var Fmc_pass:MovieClip = null;
      
      protected var FMC_Locked:MovieClip = null;
      
      protected var FBtn_enterFun:Function = null;
      
      protected var FUIComponentsHintOnOver:Function = null;
      
      protected var FUIComponentsHintOnOut:Function = null;
      
      public function CustomsUint(param1:MovieClip)
      {
         super();
         this.FThisPanel = param1;
         this.FCurIndex = int(String(this.FThisPanel.name).charAt(String(this.FThisPanel.name).length - 1));
         this.FBtn_enter = this.FThisPanel["MC_middle_"]["btn_enter"];
         this.FTF_Enter = this.FThisPanel["MC_middle_"]["TF_Enter"];
         this.FMC_Icon = this.FThisPanel["MC_middle_"]["mc_head"];
         this.Fmc_pass = this.FThisPanel["MC_middle_"]["mc_pass"];
         this.FMC_Locked = this.FThisPanel["MC_middle_"]["MC_Locked"];
         this.FBitmapHead = new Bitmap();
         if(this.FMC_Icon)
         {
            this.FMC_Icon.addChild(this.FBitmapHead);
         }
         if(this.FBtn_enter)
         {
            TGameUtil.setButtonMode(this.FBtn_enter,true);
            this.FBtn_enter.addEventListener(MouseEvent.CLICK,this.FBtn_enterFunF);
            this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.UIComponentsHintOnOverFun);
            this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.UIComponentsHintOnOutFun);
         }
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function UIComponentsHintOnOverFun(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(_loc3_);
         }
      }
      
      public function UIComponentsHintOnOutFun(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(_loc3_);
         }
      }
      
      public function set Btn_enterFun(param1:Function) : void
      {
         this.FBtn_enterFun = param1;
      }
      
      public function FBtn_enterFunF(param1:MouseEvent) : void
      {
         if(this.FBtn_enterFun != null)
         {
            this.FBtn_enterFun(this.FThisClassBelongWho,this.FCurIndex);
         }
      }
      
      public function set TF_EnterText(param1:String) : void
      {
         if(!this.FTF_Enter)
         {
            this.FTF_Enter.text = "";
            return;
         }
         this.FTF_Enter.text = param1;
      }
      
      public function set ResourceId(param1:int) : void
      {
         this.FResoureId = param1;
      }
      
      public function set ThisClassBelongWho(param1:int) : void
      {
         this.FThisClassBelongWho = param1;
      }
      
      public function get ThisClassBelongWho() : int
      {
         return this.ThisClassBelongWho;
      }
      
      public function set mc_pass(param1:Boolean) : void
      {
         this.Fmc_pass.visible = param1;
      }
      
      public function set MC_Locked(param1:Boolean) : void
      {
         this.FMC_Locked.visible = param1;
      }
      
      public function set Btn_enter(param1:Boolean) : void
      {
         this.FBtn_enter.visible = param1;
      }
      
      public function get CurIndex() : int
      {
         return this.FCurIndex;
      }
      
      public function UpdateHeadImage() : void
      {
         if(this.FThisPanel)
         {
            if(this.FThisPanel.visible)
            {
               if(this.FBitmapHead)
               {
                  if(this.FResoureId)
                  {
                     TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBitmapHead,CONST_MODULES.MODULE_Taboo,this.FResoureId);
                  }
               }
            }
         }
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}

