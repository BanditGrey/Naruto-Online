package Processors.Game.Lobby.TopOrganization.Componets
{
   import Foundation.UI.TUIComponent;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TStatusJoinMember;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_TOPORGANIZATION;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIMemberItem extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Index:TextField;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_PowerFight:TextField;
      
      protected var FType:uint;
      
      protected var FUIItemOnClick:Function;
      
      public function TUIMemberItem(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Index = FResource["TF_Index"];
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_PowerFight = FResource["TF_PowerFight"];
         super.UIDispatch();
      }
      
      override protected function UILocations() : void
      {
         FResource.addEventListener(MouseEvent.CLICK,this.MCOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TStatusJoinMember = null;
         var _loc2_:TBaseOrganizationMember = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(FContext != null)
         {
            if(FContext is TStatusJoinMember)
            {
               _loc1_ = FContext as TStatusJoinMember;
               _loc4_ = _loc1_.UserName;
               _loc5_ = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.UserLevel);
               _loc6_ = STRING_TOPORGANIZATION.STRING_IsCommitData[_loc1_.CommitStatus];
            }
            else if(FContext is TBaseOrganizationMember)
            {
               _loc2_ = FContext as TBaseOrganizationMember;
               _loc4_ = _loc2_.PlayerName;
               _loc5_ = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.PlayerLevel);
               _loc6_ = _loc2_.PlayerOrgPower.ToString();
            }
         }
         this.FTF_Index.text = (FTag + 1).toString();
         this.FTF_Name.text = _loc4_;
         this.FTF_Level.text = _loc5_;
         this.FTF_PowerFight.text = _loc6_;
      }
      
      protected function MCOnClick(param1:MouseEvent) : void
      {
         if(FContext is TBaseOrganizationMember)
         {
            if(this.FUIItemOnClick != null)
            {
               this.FUIItemOnClick(this,this.FType);
            }
         }
      }
      
      public function get UIItemOnClick() : Function
      {
         return this.FUIItemOnClick;
      }
      
      public function set UIItemOnClick(param1:Function) : void
      {
         this.FUIItemOnClick = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
   }
}

