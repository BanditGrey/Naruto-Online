package Processors.Game.Lobby.ZhenAoYi
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.DatebaseVO.VO.TSkillReform;
   import Logics.SLogicsCore;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Logics.ZhenAoYi.TZhenAoYiLogicData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.ZhenAoYi.TOverlayerZhenAoYi;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorZhenAoYi extends TProcessorLobbyWindows
   {
      
      public static const THREE:int = 3;
      
      public static const SEVEN:int = 7;
      
      public static const SKILL_COUNT:int = 2;
      
      protected var FIsInilization:Boolean;
      
      protected var FMcPanel:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FCurTabIndex:int;
      
      protected var FLogicData:TZhenAoYiLogicData;
      
      protected var FSlotVector_0:Vector.<TLittleCell>;
      
      protected var FSlotVector_1:Vector.<TLittleCell>;
      
      protected var FCurTempSkillId:uint;
      
      protected var FMC_SkillVect:Vector.<MovieClip>;
      
      protected var FSkillList:Vector.<int>;
      
      protected var FSkillIconList:Vector.<int>;
      
      protected var FSkillBmp:Vector.<Bitmap>;
      
      protected var FHelpTips:THint;
      
      protected var FOverlayerZhenAoYi:TOverlayerZhenAoYi;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      public function TProcessorZhenAoYi(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUITab = new TUITab(this);
         this.FLogicData = SLogicsCore.ZhenAoYiLogicData;
         this.FSlotVector_0 = new Vector.<TLittleCell>(SEVEN);
         this.FSlotVector_1 = new Vector.<TLittleCell>(SEVEN);
         this.FMC_SkillVect = new Vector.<MovieClip>(SKILL_COUNT);
         this.FSkillList = new Vector.<int>(SKILL_COUNT);
         this.FSkillIconList = new Vector.<int>(SKILL_COUNT);
         this.FSkillBmp = new Vector.<Bitmap>(SKILL_COUNT);
         this.FHelpTips = new THint();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         SetUIModuleID(CONST_MODULES.MODULE_ZhenAoYi);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1325400064);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(!this.FIsInilization || !this.Visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            this.FSlotVector_0[_loc1_].LogicsPerform();
            this.FSlotVector_1[_loc1_].LogicsPerform();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SKILL_COUNT)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_SkillPic,this.FSkillBmp[_loc1_],CONST_MODULES.MODULE_ZhenAoYi,this.FSkillIconList[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TLittleCell = null;
         var _loc4_:Bitmap = null;
         this.FMcPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_ZhenAoYi") as MovieClip;
         this.FMcPanel.x = (FUICore.StageWidth - this.FMcPanel.width) / 2;
         this.FMcPanel.y = (FUICore.StageHeight - this.FMcPanel.height) / 2;
         addChild(this.FMcPanel);
         this.FBtn_Close = this.FMcPanel["Btn_Close"];
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnCloseClick);
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            _loc2_ = this.FMcPanel["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc2_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            _loc3_ = new TLittleCell();
            _loc3_.BackClickFunction = this.BackClickFunction;
            _loc3_.SetPanel(this.FMcPanel["MC_Skill0"]["MC_" + _loc1_],_loc1_,1);
            _loc3_.OnSkillOver = this.OnLittleCellOver;
            _loc3_.OnSkillOut = this.OnLittleCellOut;
            this.FSlotVector_0[_loc1_] = _loc3_;
            _loc3_ = new TLittleCell();
            _loc3_.BackClickFunction = this.BackClickFunction;
            _loc3_.SetPanel(this.FMcPanel["MC_Skill1"]["MC_" + _loc1_],_loc1_,2);
            _loc3_.OnSkillOver = this.OnLittleCellOver;
            _loc3_.OnSkillOut = this.OnLittleCellOut;
            this.FSlotVector_1[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SKILL_COUNT)
         {
            _loc2_ = this.FMcPanel["MC_Skill" + _loc1_].MC_Skill;
            _loc4_ = new Bitmap();
            _loc2_.MC_Image.addChild(_loc4_);
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnSkillMove);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnHideHtmlText);
            this.FMC_SkillVect[_loc1_] = _loc2_;
            this.FSkillBmp[_loc1_] = _loc4_;
            _loc1_++;
         }
         new Tools_Help(this,this.FMcPanel["Btn_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_70170106,FUICore);
         this.FOverlayerZhenAoYi = new TOverlayerZhenAoYi(this.Parent);
         this.FOverlayerZhenAoYi.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerZhenAoYi);
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TLittleCell = null;
         var _loc4_:int = 0;
         var _loc5_:TSkill = null;
         var _loc6_:TSkillConfig = null;
         var _loc7_:int = 0;
         var _loc8_:TSkillReform = null;
         this.FLogicData.SetVectorLevelCellByType(this.FCurTabIndex + 1);
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            _loc3_ = this.FSlotVector_0[_loc1_];
            _loc3_.CurIndex = this.FCurTabIndex;
            _loc3_.Update(this.FLogicData.VectorLevelCell1.GetCellLittleByType(_loc1_));
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SEVEN)
         {
            _loc3_ = this.FSlotVector_1[_loc1_];
            _loc3_.CurIndex = this.FCurTabIndex + THREE;
            _loc3_.Update(this.FLogicData.VectorLevelCell2.GetCellLittleByType(_loc1_));
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SKILL_COUNT)
         {
            _loc2_ = this.FMC_SkillVect[_loc1_];
            if(_loc1_ == 0)
            {
               _loc7_ = int(SLogicsCore.ZhenAoYiLogicData.CurIdVector[this.FCurTabIndex]);
               if(_loc7_ == 0)
               {
                  _loc4_ = int(SLogicsCore.ZhenAoYiLogicData.VectorLevelCell1.OrgReplaceSkillID);
               }
               else
               {
                  _loc4_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillReform,_loc7_) as TSkillReform).GetSkillId;
               }
            }
            else
            {
               _loc7_ = int(SLogicsCore.ZhenAoYiLogicData.CurIdVector[this.FCurTabIndex + THREE]);
               if(_loc7_ == 0)
               {
                  _loc4_ = int(SLogicsCore.ZhenAoYiLogicData.VectorLevelCell2.OrgReplaceSkillID);
               }
               else
               {
                  _loc4_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillReform,_loc7_) as TSkillReform).GetSkillId;
               }
            }
            _loc5_ = SLogicsCore.Character.MainHero.SkillActivedByID(_loc4_);
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc4_) as TSkillConfig;
            this.FSkillIconList[_loc1_] = _loc6_.Icon;
            this.FSkillList[_loc1_] = _loc4_;
            if(_loc5_)
            {
               _loc2_.MC_Lock.visible = false;
               _loc2_.filters = [];
               _loc2_.TF_SkillName.text = _loc5_.Name;
            }
            else
            {
               _loc2_.MC_Lock.visible = true;
               _loc2_.filters = [TGameUtil.GaryColorFilters];
               _loc2_.TF_SkillName.text = _loc6_.Name;
            }
            _loc1_++;
         }
         this.FMcPanel.TF_Point.text = SLogicsCore.Character.AwakenGeneralsSoul.toString();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_ZhenAoYi_Reform_Skill,this.PACKETID_S2C_ZhenAoYi_Reform_Skill);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_S2C_ZhenAoYi_Reform_Get_Info,this.PACKETID_S2C_ZhenAoYi_Reform_Get_Info);
      }
      
      public function PACKETID_S2C_ZhenAoYi_Reform_Get_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:TSkillReform = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.readUnsignedInt();
            _loc6_ = 0;
            while(_loc6_ < this.FLogicData.CurNeedData.length)
            {
               _loc7_ = this.FLogicData.CurNeedData[_loc6_];
               if(_loc7_.Identifier == _loc5_)
               {
                  this.FLogicData.CurIdVector[_loc7_.TalentType - 1] = _loc5_;
                  break;
               }
               _loc6_++;
            }
            _loc4_++;
         }
         SLogicsCore.Character.AwakenGeneralsSoul = _loc2_.readUnsignedInt();
         this.UpdateView();
      }
      
      public function PACKETID_S2C_ZhenAoYi_Reform_Skill(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:TSkills = null;
         var _loc6_:TSkill = null;
         _loc3_ = param1.Data;
         _loc2_ = int(_loc3_.readUnsignedInt());
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedInt();
         _loc5_ = SLogicsCore.Character.MainHero.Skills;
         _loc6_ = _loc5_.GetSkillByIdentifier(this.FCurTempSkillId);
         if(_loc6_)
         {
            _loc6_.SetValueForOneselfBySkillId(_loc4_);
         }
         this.C_S_InforMation();
      }
      
      protected function C_S_InforMation() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_ZhenAoYi_Reform_Get_Info);
         _loc2_ = _loc1_.Data;
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function BackClickFunction(param1:String, param2:uint) : void
      {
         this.FCurTempSkillId = param2;
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = param1;
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_ZhenAoYi_Reform_Skill);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurTempSkillId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.UpdateView();
      }
      
      protected function OnCloseClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function OnSkillMove(param1:MouseEvent) : void
      {
         var _loc2_:TSkillConfig = null;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(8));
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,this.FSkillList[_loc3_]) as TSkillConfig;
         if(_loc2_ != null)
         {
            ProcessorOnShowHtmlText(_loc2_.Desc);
         }
      }
      
      protected function OnLittleCellOver(param1:TSkillReform, param2:Boolean) : void
      {
         if(Boolean(this.FOverlayerZhenAoYi) && Boolean(param1))
         {
            this.FOverlayerZhenAoYi.IsMax = param2;
            this.FOverlayerZhenAoYi.Context = param1;
            this.FOverlayerZhenAoYi.Render(FUICore.MouseCoordinate);
            this.FOverlayerZhenAoYi.Show();
         }
      }
      
      protected function OnLittleCellOut() : void
      {
         this.FOverlayerZhenAoYi.Hide();
      }
      
      public function set CurTabIndex(param1:int) : void
      {
         this.FCurTabIndex = param1;
         this.FUITab.TabIndex = this.FCurTabIndex;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(param1 != null)
         {
            this.FCurTabIndex = param1.readUnsignedInt();
         }
         if(!FIsResourcesLoadCompleted)
         {
            this.FUIWindowConfirmation.Load();
            return;
         }
         this.C_S_InforMation();
         this.FUITab.TabIndex = this.FCurTabIndex;
      }
      
      override public function Unmount() : void
      {
         this.FUIWindowConfirmation.Visible = false;
         super.Unmount();
      }
   }
}

